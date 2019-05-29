# ETHEREUM:

##  A SECURE DECENTRALISED GENERALISED TRANSACTION LEDGER 

BYZANTIUM VERSION 3e36772 - 2019-05-12

## 1. Introduction

### 1.1  Driving Factors.

There are many goals of this project; one key goal is to facilitate transactions between consenting individuals who would otherwise have no means to trust one another.

> facilitate : 가능하게 하다

By specifying a state-change system through a rich and unambiguous language, and furthermore architecting a system such that we can reasonably expect that an agreement will be thus enforced autonomously, we can provide a means to this end.

Overall, we wish to provide a system such that users can be guaranteed that no matter with which other individuals, systems or organizations they interact, they can do so with absolute confidence in the possible outcomes and how those outcomes might come about.

> confidence : 자신감

## 2. The Blockchain paradigm

Ethereum, taken as a whole, can be viewed as a transaction-based state machine: we begin with a genesis state and incrementally execute transactions to morph it into some final state.

It is this final state which we accept as the canonical “version” of the world of Ethereum. The state can include such information as account balances, reputations, trust arrangements, data pertaining to information of the physical world; in short, anything that can currently be represented by a computer is admissible. 

> canonical : 고전으로 여겨지는
>
> arrangements : 채비 준비
>
> pertain : 존재하다
>
> admissible : 인정되는

Transactions thus represent a valid arc between two states;

- the ‘valid’ part is important—there exist far more invalid state changes than valid state changes.
- Invalid state changes might, e.g., be things such as reducing an account balance without an equal and opposite increase elsewhere.

Blocks function as a journal, recording a series of transactions together with the previous block and ***an identifier for the final state (though do not store the final state itself—that would be far too big).*** They also punctuate the transaction series with incentives for nodes to mine. ***This incentivisation takes place as a state-transition function, adding value to a nominated account.***

> punctuate : 간간히 끼어들다, 구두점을 찍다.

```
σ_t+1 ≡ Π(σ_t, B)
B ≡ (..., (T0, T1, ...), ...)
Π(σ, B) ≡ Ω(B, Υ(Υ(σ, T0), T1)...)
```

***where `Υ` is the Ethereum state transition function.*** Where `Ω` is the block-finalisation state transition function (a function that rewards a nominated party); ***`B` is this block, which includes a series of transactions amongst some other components;*** and `Π` is the block-level state-transition function.

### 2.1 Value

- 10^0 Wei
- 10^12 Szabo
- 10^15 Finney
- 10^18 Ether

### 2.2 Which History?

If there is ever a disagreement between nodes as to which root-to-leaf path down the block tree is the ‘best’ blockchain, then a fork occurs.

***This would mean that past a given point in time (block), multiple states of the system may coexist:*** some nodes believing one block to contain the canonical transactions, other nodes believing some other block to be canonical, potentially containing radically different or incompatible transactions. ***This is to be avoided at all costs as the uncertainty that would ensue would likely kill all confidence in the entire system.***

> ensue  : (결과가)뒤따르다

The scheme we use in order to generate consensus is a simplified version of the GHOST protocol.

## 3. Convention

The two sets of highly structured, ***‘top-level’, state values, are denoted with bold lowercase Greek letters.*** They fall into those of world-state, which are denoted `σ` (or a variant thereupon) and those of machine-state, `µ`.

> thereupon : 그러자 곧

***Functions operating on highly structured values are denoted with an upper-case Greek letter,*** e.g. `Υ`, the Ethereum state transition function.

For most functions, an uppercase letter is used, e.g. `C`, the general cost function. These may be subscripted to denote specialised variants, e.g. `CSSTORE`, the cost function for the `SSTORE` operation. 

> subscripted  : 첨자를 붙인

the Keccak-256 hash function, is denoted `KEC` (and generally referred to as plain Keccak). Also KEC512 is referring to the `Keccak 512` hash function.

Tuples are typically denoted with an upper-case letter, e.g. `T`, is used to denote an Ethereum transaction. `T_n`, denotes the nonce of said transaction.

`n` is used in the document to denote a transaction nonce. `δ`, the number of items required on the stack for a given operation.

`o` is used to denote the byte sequence given as the output data of a message call.

the set of all byte sequences of length 32 is named `B_32` and the set of all non-negative integers smaller than 2^256 is named `N_256`.

`µ_s[0]` denotes the first item on the machine’s stack.

the unmodified ‘input’ value be denoted by the placeholder  then the modified and utilisable value is denoted as ', and intermediate values would be *, ** &c. (  : Somthing)

We define a number of useful functions throughout. One of the more common is `l`, which evaluates to the last item in the given sequence

## 4. Blocks, State And Transactions

### 4.1 World State

The world state (state), is a mapping between addresses (160-bit identifiers) and account states.

Though not stored on the blockchain, it is assumed that the implementation will maintain this mapping in a modified Merkle Patricia tree 

#### Modified Merkle Patricia Tree(Appendix D)

The modified Merkle Patricia tree (trie) provides a persistent data structure to map between arbitrary-length binary
data (byte arrays). ***It is defined in terms of a mutable data structure to map between 256-bit binary fragments and arbitrary-length binary data, typically implemented as a database.*** The core of the trie, and its sole requirement in terms of the protocol specification, ***is to provide a single value that identifies a given set of key-value pairs,*** which may be either a 32-byte sequence or the empty byte sequence. It is left as an implementation consideration to store and maintain the structure of the trie in a manner that allows effective and efficient realisation of the protocol. 

***The trie requires a simple database backend that maintains a mapping of byte arrays to byte arrays;*** we name this underlying database the state ***database.***

This has a number of benefits;

- firstly the root node of this structure is cryptographically dependent on all internal data and as such its hash can be used as a secure identity for the entire system state.
- Secondly, being an immutable data structure, ***it allows any previous state (whose root hash is known) to be recalled by simply altering the root hash accordingly.***
  ***Since we store all such root hashes in the blockchain, we are able to trivially revert to old states.***

> revert  : 되돌아가다, 복귀하다.

The account state, `σ[a]`, comprises the following four fields:

- nonce: A scalar value equal to the number of transactions sent from this address or, in the case of accounts with associated code, the number of contract-creations made by this account. For account of address a in state σ, this would be formally denoted `σ[a]_n`.
- balance: A scalar value equal to the number of Wei owned by this address. Formally denoted `σ[a]_b`.
- storageRoot: ***A 256-bit hash of the root node of a Merkle Patricia tree*** that encodes the storage contents of the account (a mapping between 256-bit integer values), encoded into the trie as a mapping from the Keccak 256-bit hash of the 256-bit integer keys to the RLP-encoded 256-bit integer values. The hash is formally denoted `σ[a]_s`.
- codeHash: ***The hash of the EVM code of this account***—this is the code that gets executed should this address receive a message call; ***it is immutable and thus, unlike all other fields, cannot be changed after construction.*** All such code fragments are contained in the state database under their corresponding hashes for later retrieval. This hash is formally denoted `σ[a]_c`, and thus the code may be denoted as `b`, given that KEC(b) = `σ[a]_c`.

> transaction : EOA -> CA
>
> message : CA -> CA

Since we typically wish to refer not to the trie’s root hash but to ***the underlying set of key/value pairs stored within,***

If the codeHash field is the Keccak-256 hash of the empty string, i.e. `σ[a]_c` = `KEC (())` , then the node represents a simple account, sometimes referred to as a “non-contract” account.

***An account is empty when it has no code, zero nonce and balance.*** Even callable precompiled contracts can have an empty account state. This is because their account states do not usually contain the code describing its behavior. ***An account is dead when its account state is non-existent or empty***

###  4.2 The transaction.