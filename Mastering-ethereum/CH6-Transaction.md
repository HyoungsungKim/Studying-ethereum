# CH6 Transactions

***Transactions are signed messages originated by an externally owned account, transmitted by the Ethereum network, and recorded on the Ethereum blockchain.*** 

> Externally owned account(EOA) makes transactions

This basic definition conceals a lot of surprising and fascinating details. ***Another way to look at transactions is that they are the only things that can trigger a change of state, or cause a contract to execute in the EVM.*** Ethereum is a global singleton state machine, and transactions are what make that state machine "tick," changing its state. Contracts don’t run on their own. Ethereum doesn't run autonomously. ***Everything starts with a transaction.***

## The Structure of a Transaction

A transaction is a serialized binary message that contains the following data:

- Nonce

   A sequence number, issued by the originating EOA, used to prevent message replay 

  >  EOA : Externally owned account

- Gas price

   The price of gas (in wei) the originator is willing to pay 

- Gas limit

   The maximum amount of gas the originator is willing to buy for this transaction 

- Recipient

   The destination Ethereum address 

- Value

   The amount of ether to send to the destination 

- Data

   The variable-length binary data payload 

- v,r,s

   The three components of an ECDSA digital signature of the originating EOA 

***The transaction message’s structure is serialized using the Recursive Length Prefix (RLP) encoding scheme, which was created specifically for simple, byte-perfect data serialization in Ethereum.*** All numbers in Ethereum are encoded as big-endian integers, of lengths that are multiples of 8 bits.

Note that the field labels (to, gas limit, etc.) are shown here for clarity, ***but are not part of the transaction serialized data, which contains the field values RLP-encoded.*** In general, RLP does not contain any field delimiters or labels. ***RLP’s length prefix is used to identify the length of each field.*** Anything beyond the defined length belongs to the next field in the structure.

While this is the actual transaction structure transmitted, most internal representations and user interface visualizations embellish this with additional information, derived from the transaction or from the blockchain.

> embellish : 꾸미다, 치장하다.

***For example, you may notice there is no “from” data in the address  identifying the originator EOA.*** That is because ***the EOA’s public key can be derived from the v,r,s components of the ECDSA signature.*** The address can, in turn, be derived from the public key. Other metadata frequently added to the transaction by client software includes the block number (once it is mined and included in the blockchain) and a transaction ID (calculated  hash). ***Again, this data is derived from the transaction, and does not form part of the transaction message itself.***

## The Transaction Nonce

The nonce is one of the most important and least understood components of a transaction. 

> Def in this book)
>
> nonce : A sequence number, issued by the originating EOA, used to prevent message replay
>
> Def in ethereum yellow paper
>
> nonce: A scalar value equal to the number of transactions sent from this address or, in the case of accounts with associated code, the number of contract-creations made by this account.
>
> -> 메시지 반복을 막기 위한 일련의 숫자

***Strictly speaking, the nonce is an attribute of the originating address;*** that is, it only has meaning in the context of the sending address. However, the nonce is not stored explicitly as part of an account’s state on the blockchain. Instead, ***it is calculated dynamically, by counting the number of confirmed transactions that have originated from an address.***

There are two scenarios where the existence of a transaction-counting nonce is important:

- The usability feature of transactions being included in the order of creation
- The vital feature of transaction duplication protection.

1. Imagine you wish to make two transactions. You have an important  payment to make of 6 ether, and also another payment of 8 ether. Sadly, you have overlooked the fact that your account contains only 10 ether, so the network can’t accept both transactions: ***However, in a decentralized system like Ethereum, nodes may receive the transactions in either order; there is no  guarantee that a particular node will have one transaction propagated to it before the other.***  Without the nonce, it would be random as to  which one gets accepted and which rejected. ***However, with the nonce  included, the first transaction you sent will have a nonce of, let’s  say, 3, while the 8-ether transaction has the next nonce value (i.e.,  4). So, that transaction will be ignored until the transactions with  nonces from 0 to 3 have been processed, even if it is received first.***
2. Without a nonce value in the transaction, a second  transaction sending 2 ether to the same address a second time will look exactly the same as the first transaction. ***This means that anyone who  sees your transaction on the Ethereum network can "replay" the transaction  again and again until all your ether is gone simply by copying  and pasting your original transaction and resending it to the network.***  However, ***with the nonce value included in the transaction data, every single transaction is unique***,  even when sending the same amount of ether to the same recipient address multiple times. ***Thus, by having the incrementing nonce as part  of the transaction, it is simply not possible for anyone to "duplicate" a  payment you have made.***

### Keeping Track of Nonces

In practical terms, the nonce is an up-to-date count of the number of *confirmed* (i.e., on-chain) transactions that have originated from an account.

Your wallet will keep track of nonces for each address it manages. When you create a new transaction, you assign the next nonce in the sequence. ***But until it is confirmed, it will not count toward the getTransactionCount total.***

### Gaps in Nonce, Duplicated Nonces and Confirmed

The Ethereum network processes transactions sequentially, based on the nonce. That means that if you transmit a transaction with nonce 0 and then transmit a transaction with nonce 2, the second transaction will not be included in any blocks. ***It will be stored in the mempool, while the Ethereum network waits for the missing nonce to appear.*** All nodes will assume that the missing nonce has simply been delayed and that the transaction with nonce 2 was received out of sequence.

What this means is that if you create several transactions in sequence and one of them does not get officially included in any blocks, all the subsequent transactions will be "stuck," waiting for the missing nonce. A transaction can create an inadvertent "gap" in the nonce sequence because it is invalid or has insufficient gas.

A transaction can create an inadvertent "gap" in the nonce sequence because it is invalid or has insufficient gas. To get things moving again, you have to transmit a valid transaction with the missing nonce. You should be equally mindful that once a transaction with the "missing" nonce is validated by the network, all the broadcast transactions with subsequent nonces will incrementally become valid; it is not possible to "recall" a transaction!

> inadvertent : 부주의한
>
> mindful : 유의하는, ~을 염두에 두는

If, on the other hand, you accidentally ***duplicate a nonce***, for example by transmitting two transactions with the same nonce but different recipients or values, then one of them will be confirmed and one will be rejected. ***it will be fairly random.***

### Concurrency, Transaction Origination and Nonce

> In concurrency system, handling nonce is so difficult

Ethereum, by definition, is a system that allows concurrency of operations (nodes, clients, DApps) but enforces a singleton state through consensus.

These concurrency problems, on top of the difficulty of tracking account balances and transaction confirmations in independent processes, force most implementations toward avoiding concurrency and creating bottlenecks ***such as a single process handling all withdrawal transactions in an exchange, or setting up multiple hot wallets that can work completely independently for withdrawals and only need to be intermittently rebalanced.***

> Intermittently : 간헐적으로

## Transaction Gas

Gas is the fuel of Ethereum. ***Gas is not ether—it’s a separate virtual currency with its own exchange rate against ether.*** The open-ended (Turing-complete) computation model requires some form of metering in order to avoid denial-of-service attacks or inadvertently resource-devouring transactions.

Gas is separate from ether in order to protect the system from the volatility that might arise along with rapid changes in the value of ether, and also as a way to manage the important and sensitive ratios between the costs of the various resources that gas pays for (namely, computation, memory, and storage).

Wallets can adjust the gasPrice in transactions they originate to achieve faster confirmation of transactions. 

***The gasPrice field in a transaction allows the transaction originator to set the price they are willing to pay in exchange for gas.***

***In simple terms, gasLimit gives the maximum number of units of gas the transaction originator is willing to buy in order to complete the transaction.***

***If your transaction’s destination address is a contract, then the amount of gas needed can be estimated but cannot be determined with accuracy.*** That’s because a contract can evaluate different conditions that lead to different execution paths, with different total gas costs.

> analogy : 유사, 유추

## Transaction Recipient

The recipient of a transaction is specified in the to field. ***This contains a 20-byte Ethereum address.*** The address can be an EOA or a contract address.

Ethereum does no further validation of this field. ***Any 20-byte value is considered valid. If the 20-byte value corresponds to an address without a corresponding private key, or without a corresponding contract, the transaction is still valid.*** 

***Ethereum has no way of knowing whether an address was correctly derived from a public key (and therefore from a private key) in existence.***

## Transaction Value and Data

***The main "payload" of a transaction is contained in two fields:***

- value
- data

Transactions can have both value and data, only value, only data, or neither value nor data. All four combinations are valid.

> payload : 탑재량

- A transaction with only value is a ***payment***.
- A transaction with only data is an ***invocation***.
- A transaction with both value and data is both a ***payment and an invocation.***
- A transaction with neither value nor data—well that’s probably just a ***waste of gas!*** But it is still possible.

> invocation : (컴퓨터)(법적 권한 등의) 발동[실시]

### Transmitting Value to EOAs and Contracts

When you construct an Ethereum transaction that contains a value, it is the equivalent of a *payment*. ***Such transactions behave differently depending on whether the destination address is a contract or not.***

Ethereum will record a state change, adding the value you sent to the balance of the address. ***If the address has not been seen before, it will be added to the client’s internal representation of the state and its balance initialized to the value of your payment.***

***If the destination address (to) is a contract, then the EVM will execute the contract and will attempt to call the function named in the data payload of your transaction.*** If there is no data in your transaction, the EVM will call a *fallback* function and, if that function is payable, will execute it to determine what to do next.

> fallback function : 트랜젝션이 컨트랙트에 이더를 송금했으나 메소드를 호출하지 않은 경우에 실행

### Transmitting a Data Payload to an EOA or Contract

***When your transaction contains data, it is most likely addressed to a contract address. That doesn't mean you cannot send a data payload to an EOA—that is completely valid in the Ethereum protocol.***

However, in that case, the interpretation of the data is up to the wallet you use to access the EOA. It is ignored by the Ethereum protocol. ***Most wallets also ignore any data received in a transaction to an EOA they control.***

## Special Transaction Contract Creation

One special case that we should mention is a transaction that ***creates a new contract*** on the blockchain, deploying it for future use. Contract creation transactions are sent to a special destination address called the *zero address*; the to field in a contract registration transaction contains the address 0x0. ***This address represents neither an EOA (there is no corresponding private–public key pair) nor a contract.*** It can never spend ether or initiate a transaction. ***It is only used as a destination, with the special meaning "create this contract."***

***While the zero address is intended only for contract creation, it sometimes receives payments from various addresses. There are two explanations for this:***

- either it is by accident, resulting in the loss of ether
- it is an intentional *ether burn* 

***You can include an ether amount in the value field if you want to set the new contract up with a starting balance, but that is entirely optional. If you send a value (ether) to the contract creation address without a data payload (no contract), then the effect is the same as sending to a burn address—there is no contract to credit, so the ether is lost.***

```solidity
web3.eth.account[0]
```

## Digital Signatures

