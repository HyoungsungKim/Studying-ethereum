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

***Ethereum, taken as a whole, can be viewed as a transaction-based state machine***: we begin with a genesis state and incrementally execute transactions to morph it into some final state.

It is this final state which we accept as the canonical “version” of the world of Ethereum. ***The state can include such information as account balances, reputations, trust arrangements, data pertaining to information of the physical world;*** in short, anything that can currently be represented by a computer is admissible. 

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

A valid state transition is one which comes about through a transaction.
$$
\sigma _{t+1} \equiv \gamma(\sigma _t, T)
$$

> $\gamma$ is Ethereum state transition function
>
> -> it means gamma function change state using transaction(T)

Blocks function as a journal, ***recording a series of transactions together with the previous block*** and ***an identifier for the final state (though do not store the final state itself—that would be far too big).*** They also punctuate the transaction series with incentives for nodes to mine. ***This incentivisation takes place as a state-transition function, adding value to a nominated account.***

> 블록은 마지막 state를 저장하는게 아니라 마지막 state를 식별 할 수 있는 식별자를 저장하고 있음.
>
> punctuate : 간간히 끼어들다, 구두점을 찍다.

Mining is the process of dedicating effort (working) to bolster one series of transactions (a block) over any other potential competitor block. It is achieved thanks to a cryptographically secure proof. This scheme is known as a proof-of-work.
$$
\begin{array}\\
σ_{t+1} ≡ Π(σ_t, B) \\
B ≡ (..., (T0, T1, ...), ...) \\
Π(σ, B) ≡ Ω(B, Υ(Υ(σ, T0), T1)...) \\
\end{array}
$$

> $\textstyle \prod$  : block level state-transition function ($\gamma$ : transaction level state-transition function)
>
> $B$ : Block which includes a series of transactions
>
> Ω : The block-finalisation state transition function (a function that rewards a nominated party);
>
> Ω : 블록의 마지막 state를 전파

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

***Functions operating on highly structured values are denoted with an upper-case Greek letter,*** e.g. $\gamma $, the Ethereum state transition function.

For most functions, an uppercase letter is used, e.g. `C`, the general cost function. These may be subscripted to denote specialised variants, e.g. $C_{SSTORE}$, the cost function for the `SSTORE` operation. 

> subscripted  : 첨자를 붙인

the Keccak-256 hash function, is denoted `KEC` (and generally referred to as plain Keccak). Also KEC512 is referring to the `Keccak 512` hash function.

Tuples are typically denoted with an upper-case letter, e.g. `T`, is used to denote an Ethereum transaction. `T_n`, denotes the nonce of said transaction.

`n` is used in the document to denote a transaction nonce.

`δ`, the number of items required on the stack for a given operation.

`o` is used to denote the byte sequence given as the output data of a message call.

we assume scalars are ***non-negative integers*** and thus belong to the set $\mathbb{N}$

The set of all ***byte sequences*** is $\mathbb{B}$

the set of all non-negative integers smaller than $2^256$ is named $\mathbb{N}_{256}$.

the set of all byte sequences of length 32 is named $\mathbb{B}_{32}$

$\mu_s[0]$ denotes the first item on the machine’s stack.

$\mu_m[0..31]$ denotes the first 32 items of the machine’s memory.

> $\sigma$ : global state(world state) : which is a sequence of accounts, themselves tuples, the square brackets are used to reference an individual account.
>
> $\mu$ : machine state 

the unmodified ‘input’ value be denoted by the placeholder  then the modified and utilisable value is denoted as ', and intermediate values would be *, ** &c. (  : Something)

We define a number of useful functions throughout. One of the more common is  $l$, which evaluates to the last item in the given sequence
$$
l \equiv x[\lVert x \rVert - 1]
$$


## 4. Blocks, State And Transactions

### 4.1 World State

***The world state (state), is a mapping between addresses (160-bit identifiers) and account states.***

Though not stored on the blockchain, ***it is assumed that the implementation will maintain this mapping in a modified Merkle Patricia tree***

#### Modified Merkle Patricia Tree(Appendix D)

The modified Merkle Patricia tree (trie) provides a persistent data structure to map between arbitrary-length binary
data (byte arrays). ***It is defined in terms of a mutable data structure to map between 256-bit binary fragments and arbitrary-length binary data, typically implemented as a database.*** The core of the trie, and its sole requirement in terms of the protocol specification, ***is to provide a single value that identifies a given set of key-value pairs,*** which may be either a 32-byte sequence or the empty byte sequence. It is left as an implementation consideration to store and maintain the structure of the trie in a manner that allows effective and efficient realisation of the protocol. 

***The trie requires a simple database backend that maintains a mapping of byte arrays to byte arrays;*** we name this underlying database the state ***database.***

This has a number of benefits;

- firstly the root node of this structure is cryptographically dependent on all internal data and as such its hash can be used as a secure identity for the entire system state.
- Secondly, being an immutable data structure, ***it allows any previous state (whose root hash is known) to be recalled by simply altering the root hash accordingly. Since we store all such root hashes in the blockchain, we are able to trivially revert to old states.***

> revert  : 되돌아가다, 복귀하다.

The account state, `σ[a]`, comprises the following four fields:

- nonce($σ[a]_n$): A scalar value equal to the number of transactions sent from this address or, in the case of accounts with associated code, the number of contract-creations made by this account.
- balance($σ[a]_b$): A scalar value equal to the number of Wei owned by this address.
- storageRoot($σ[a]_s$): ***A 256-bit hash of the root node of a Merkle Patricia tree*** that encodes the storage contents of the account (a mapping between 256-bit integer values), encoded into the tree as a mapping from the Keccak 256-bit hash of the 256-bit integer keys to the RLP-encoded 256-bit integer values.

> storageRoot : Keccak로 해쉬화 된 Merkle particia tree의 root node를 저장 함

- codeHash($σ[a]_c$): ***The hash of the EVM code of this account***—this is the code that gets executed should this address receive a message call; ***it is immutable and thus, unlike all other fields, cannot be changed after construction.*** All such code fragments are contained in the state database under their corresponding hashes for later retrieval. Thus the EVM code may be denoted as $\bold{b}$, given that $KEC(\bold{b}) = σ[a]_c$.

> $KEC(\bold{b}) = σ[a]_c$ : EVM code b의 kec 해시 결과는 index a state의 코드 해시
>
> transaction : EOA -> CA
>
> message : CA -> CA

Since ***we typically wish to refer not to the trie’s root hash but to the underlying set of key/value pairs stored within,*** we define a convenient equivalence
$$
TRIE(L^*_I(\sigma[a]_s)) \equiv \sigma[a]_s \\
L_I((k, v)) \equiv (KEC(k), RLP(v))\\
k \in \mathbb{b} \  \and \ v \in \mathbb{n}
$$
The collapse function for the set of key/value pairs in the trie, $L^*_I$

If the codeHash field is the Keccak-256 hash of the empty string, i.e. $σ[a]_c = KEC (())$ , then the node represents a simple account, sometimes referred to as a “non-contract” account.

We may define a world-state collapse function LS
$$
L_S(σ) ≡ (p(a) : σ[a] \neq \empty ) \\
p(a) ≡ (KEC(a), RLP (σ[a]_n, σ[a]_b, σ[a]_s, σ[a]_c)
$$
This function, $L_S$, is used alongside the trie function to provide a short identity (hash) of the world state.

Definition of empty
$$
EMPTY(σ, a) ≡ (σ[a]_c = KEC(()) ∧σ[a]_n = 0∧σ[a]_b = 0)
$$

> codehash 가 없고(empty), nonce와 balance가 0인 상태를 empty라고 함

***An account is empty when it has no code, zero nonce and balance.*** Even callable precompiled contracts can have an empty account state. This is because their account states do not usually contain the code describing its behavior. ***An account is dead when its account state is non-existent or empty***

###  4.2 The transaction

A transaction (formally, T) is a single cryptographically-signed instruction constructed by an actor externally to the scope of Ethereum.

There are two types of transactions:

- Those which ***result in message calls***
- Those which ***result in the creation of new accounts with associated code*** (known informally as ‘contract creation’). 

Both types specify a number of common fields:

- nonce($T_n$) : the number of transactions sent by the sender
- gasPrice($T_p$) : number of Wei to be paid per unit of gas
- gasLimit($T_g$) : The 160-bit address of the message call’s recipient or, for a contract creation transaction
- to($T_t$) : The 160-bit address of the message call’s recipient or, for a contract creation transaction
- value($T_v$) : the number of Wei to be transferred to the message call’s recipient or,contract creation
- v, r, s($T_w$, $T_r$, $T_s$) : Values corresponding to the signature of the transaction and ***used to determine the sender of the transaction***

Contract creation transaction contains

- init($T_i$) : ***An unlimited size byte array specifying the EVM-code*** for the account initialisation procedure, formally Message call transaction contains

- data($T_d$) : An unlimited size byte array specifying the input data of the message call.

$$
L_T(T) ≡
\begin{cases}
(Tn, Tp, Tg, Tt, Tv, Ti, Tw, Tr, Ts) & \text{if } {T_t} = ∅\\
(Tn, Tp, Tg, Tt, Tv, Td, Tw, Tr, Ts) & otherwise
\end{cases}
$$

> Transaction from EOA : including $T_i$
>
> Transaction from CA : including $T_d$

### 4.3 The Block

The block in Ethereum is the collection of relevant pieces of information (known as the block header), `H`, together with information corresponding to the comprised transactions, `T`, and a set of other block headers `U` that are known to have a parent equal to the present block’s parent’s parent (such blocks are known as ommers - uncle block). The block header contains several pieces of information:

> `H`, `T`, `U` are defined as $B_H$, $B_T$, $B_U$

- parentHash: The Keccak 256-bit hash of the parent block’s header, in its entirety; formally $H_p$.

- ommersHash(uncle hash) : The Keccak 256-bit hash of the ommers list portion of this block; formally $H_o$.

- beneficiary: The 160-bit address to which all fees collected from the successful mining of this block be transferred; formally $H_c$.

- stateRoot: The Keccak 256-bit hash of ***the root node of the state tree,*** after all transactions are executed and finalisations applied; formally $H_r$.

- transactionsRoot: The Keccak 256-bit hash of ***the root node of the tree structure populated with each transaction in the transactions list portion*** of the block; formally $H_t$.

  > populate : 채우다

  

- receiptsRoot: The Keccak 256-bit hash of the ***root node of the tree structure populated with the receipts of each transaction in the transactions*** list portion of the block; formally $H_e$.

- logsBloom: The Bloom filter composed from indexable information (logger address and log topics) contained in each log entry from the receipt of each transaction in the transactions list; formally $H_b$.

- difficulty: A scalar value corresponding to the difficulty level of this block. ***This can be calculated from the previous block’s difficulty level and the timestamp***; formally $H_d$.

- number: A scalar value equal to ***the number of ancestor blocks.*** The genesis block has a number of zero; formally $H_i$.

- gasLimit: A scalar value equal to the ***current limit of gas expenditure per block;*** formally $H_l$.

- gasUsed: A scalar value equal to the ***total gas used in transactions in this block;*** formally $H_g$.

- timestamp: A scalar value equal to the reasonable output of Unix’s time() at this block’s inception; formally $H_s$.

- extraData: An arbitrary byte array containing data relevant to this block. This must be 32 bytes or fewer; formally $H_x$

- mixHash: A 256-bit hash which, combined with the nonce, proves that a sufficient amount of computation has been carried out on this block; formally $H_m$.

- nonce: A 64-bit value which, combined with the mixhash, proves that a sufficient amount of computation has been carried out on this block; formally $H_n$.

The other two components in the block are simply a list of ommer block headers (of the same format as above), $B_U$ and a series of the transactions, $B_T$. Formally, we can refer to a block B:
$$
B ≡ (B_H, B_T, B_U)
$$

> Contents of a block
>
> $B_H$ : The block in Ethereum is the collection of relevant pieces of information (known as the block header)
>
> $B_T$ : A series of the transactions
>
> $B_U$ : A list of ommer block headers (of the same format as above) 

### 4.3.1 Transaction Receipt

In order to encode information about a transaction concerning which it may be useful to form a zero-knowledge proof, or index and search, ***we encode a receipt of each transaction containing certain information from its execution.***

Each receipt, denoted $B_R[i]$ for the *i*th transaction, is placed in an index-keyed tree and the root recorded in the header as $H_e$.

The transaction receipt, R, is a tuple of four items comprising:

- the ***cumulative gas*** used in the block containing the transaction receipt as of immediately after the transaction has happened $R_u$
- the ***set of logs*** created through execution of the transaction $R_l$ 
- the ***Bloom filter*** composed from information in those logs $R_b$
- the ***status code*** of the transaction, $R_z$

$$
R ≡ (R_u, R_b, R_l, R_z)
$$

### 4.3.2 Holistic validity

> Holistic  : 전체론적, 전체론의 (전체론 : 기관 전체가 그것을 이루고 있는 부분들의 동작이나 작용을 결정)

We can assert a block’s validity if and only if it satisfies several conditions:

it must be internally consistent with the ommer and transaction block hashes and the given transactions $B_{T}$ , when executed in order on the base state `σ` (derived from the final state of the parent block), result in a new state of the identity $H_r$

> $B_T$ : A series of the transactions
>
> $H_r$ : stateRoot: The Keccak 256-bit hash of the root node of the state tree

$$
\begin{array}\\
H_r ≡ TRIE(L_S(Π(σ, B))) \\
H_o ≡ KEC(RLP(L^∗_H(B_U)))\\
H_t ≡ TRIE({∀i < \lVert B_T \rVert, i ∈ N : p(i, L_T(B_T[i]))})\\
H_e ≡ TRIE({∀i < \lVert B_R \rvert, i ∈ N : p(i, L_R(B_R[i]))}) \\
H_b ≡ \bigvee _{r∈B_R} (r_b)\\
\end{array}
$$

