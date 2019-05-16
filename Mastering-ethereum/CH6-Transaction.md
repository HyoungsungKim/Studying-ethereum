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