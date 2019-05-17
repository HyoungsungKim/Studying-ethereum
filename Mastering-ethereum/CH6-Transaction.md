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

