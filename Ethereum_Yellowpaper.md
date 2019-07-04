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

- $10^0$ Wei
- $10^12$ Szabo
- $10^{15}$ Finney
- $10^{18}$ Ether

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

the set of all non-negative integers smaller than $2^{256}$ is named $\mathbb{N}_{256}$.

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

We may define a world-state collapse function $L_{S}$
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

- parentHash($H_p$): The Keccak 256-bit hash of the parent block’s header, in its entirety;.

- ommersHash(uncle hash,  $H_o$) : The Keccak 256-bit hash of the ommers list portion of this block

- beneficiary($H_c$): The 160-bit address to which all fees collected from the successful mining of this block be transferred.(이더가 전송 될 주소)

- stateRoot($H_r$): The Keccak 256-bit hash of ***the root node of the state tree,*** after all transactions are executed and finalisations applied.

- transactionsRoot($H_t$): The Keccak 256-bit hash of ***the root node of the tree structure populated with each transaction in the transactions list portion*** of the block.

  > populate : 채우다

  

- receiptsRoot($H_e$.): The Keccak 256-bit hash of the ***root node of the tree structure populated with the receipts of each transaction in the transactions*** list portion of the block.

- logsBloom($H_b$): The Bloom filter composed from indexable information (logger address and log topics) contained in each log entry from the receipt of each transaction in the transactions list.

- difficulty($H_d$): A scalar value corresponding to the difficulty level of this block. ***This can be calculated from the previous block’s difficulty level and the timestamp***.

- number($H_i$): A scalar value equal to ***the number of ancestor blocks.*** The genesis block has a number of zero.

- gasLimit($H_l$): A scalar value equal to the ***current limit of gas expenditure per block .***

- gasUsed($H_g$): A scalar value equal to the ***total gas used in transactions in this block.***

- timestamp($H_s$): A scalar value equal to the reasonable output of Unix’s time() at this block’s inception .

- extraData($H_x$): An arbitrary byte array containing data relevant to this block. This must be 32 bytes or fewer. 

- mixHash($H_m$): A 256-bit hash which, combined with the nonce, proves that a sufficient amount of computation has been carried out on this block; formally .

- nonce($H_n$): A 64-bit value which, combined with the mixhash, proves that a sufficient amount of computation has been arried out on this block; formally.

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

> $H_e$ : receiptsRoot 

The transaction receipt, $R$, is a tuple of four items comprising:

- the ***cumulative gas*** - $R_u$ used in the block containing the transaction receipt as of immediately after the transaction has happened 
- the ***set of logs*** - $R_l$ created through execution of the transaction  
- the ***Bloom filter*** - $R_b$ composed from information in those logs 
- the ***status code*** - $R_z$ of the transaction, 

$$
R ≡ (R_u, R_b, R_l, R_z)
$$

The function $L_R$ trivially prepares a transaction receipt for being transformed into an RLP-serialised byte array:
$$
L_R(R) \equiv (0 \in \mathbb{B}_{256},R_u,R_b,R_l)
$$

>$\mathbb{B}$ : byte
>
>$\mathbb{N}$ : non-negative integers smaller than $2^{256}$

***The sequence $R_l$ is a series of log entries, ($O_0$, $O_1$, ...).***

> $R_l$ : set of logs

- $O_a$ a tuple of the logger’s address
- $O_t$ a possibly empty series of 32-byte log topics
- $O_d$ some number of bytes of data

$$
O \equiv (O_a, (O_{t0}, O_{t1}, ...), O_d)
$$

We define the ***Bloom filter function, M,*** to reduce a log entry into a single 256-byte hash:
$$
M(O) \equiv \bigvee_{x \in{O_a}\cup O_t}(M_{3:2048}(x))
$$
where$M_{3:2048}$ is a specialised Bloom filter that ***sets three bits out of 2048***, given an arbitrary byte sequence.

It does this through taking the ***low-order 11 bits of each of the first three pairs of bytes in a Keccak-256 hash of the byte sequence.***

where $\beta$ is the bit reference function such that $\beta_j(x)$ equals the bit of index j (indexed from 0) in the byte array x.

> $\beta_{m(x,i)}(y)$ : in the byte array $y$, index of $m(x,i)$
>
> $m(x, i) ≡ KEC(x)[i, i + 1] mod 2048 $ : KEC(x) 결과의 [i, i+1] index의 mod 결과

$$
\begin{align} \\
M_{3:2048}(x : x ∈ \mathbb {B}) ≡ y : y ∈ \mathbb{B}_{256} \ {where:} \\
y = (0, 0, ..., 0) \ except: \\
∀i ∈ (0, 2, 4) : \beta_{m(x,i)}(y) = 1 \\
m(x, i) ≡ KEC(x)[i, i + 1] mod 2048 \\
\end{align}
$$

> $\beta$의 결과에 해당하는 곳만 1 나머지는 0.

### 4.3.2 Holistic validity

> Holistic  : 전체론적, 전체론의 (전체론 : 기관 전체가 그것을 이루고 있는 부분들의 동작이나 작용을 결정)
>
> assert : 주장하다
>
> revert : 되돌아가다

We can assert a block’s validity ***if and only if it satisfies several conditions:***

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

> $H_r$(state root) :The Keccak 256-bit hash of ***the root node of the state tree,*** after all transactions are executed and finalisations applied.
>
> $H_o$ (ommer hash):  Keccak 256-bit hash of the ommers list portion of this block
>
> $H_t$(transsctionsRoot) : The Keccak 256-bit hash of ***the root node of the tree structure populated with each transaction in the transactions list portion*** of the block.
>
> $H_e$(receiptsRoot) : The Keccak 256-bit hash of the ***root node of the tree structure populated with the receipts of each transaction in the transactions*** list portion of the block.
>
> The function $L_R$ trivially prepares a transaction receipt for being transformed into an RLP-serialised byte array
>
> $H_b$(logsBloom) : The Bloom filter composed from indexable information (logger address and log topics) contained in each log entry from the receipt of each transaction in the transactions list.

where p(k, v) is simply the pairwise RLP transformation.

> RLP : 단어들을(json) 하나의 string으로 변환

$$
p(k,v) \equiv (RLP(k), RLP(v)) \\
TRIE(L_s(\sigma)) \equiv P(B_H)_{H_r}
$$

Thus $TRIE(L_S (\sigma))$ is the root node hash of the Merkle Patricia tree structure containing the key-value pairs of
the state $\sigma$ with values encoded using `RLP`, and ***$P(B_H)$ is the parent block of `B`, defined directly.***

### 4.3.3 Serialization

The function $L_B$ and $L_H$ are the preparation functions for a block and block header respectively.
$$
\begin{array} \\
L_H(H) \equiv (H_p, H_o, H_c, H_r, H_t, H_e, H_b, H_d, H_i, H_l, H_g, H_s, H_x, H_m, H_n) \\
L_B(B) \equiv (L_H(B_H), L^*_T(B_T),L^*_T(B_U))
\end{array}
$$
With $L^*_T$and $L^∗_H$ being element-wise sequence transformations,
$$
f^*((x_0, x_1, x_2, ...)) \equiv (f(x_0), f(x_1), f(x_2), ...)
$$

### 4.3.4 Block Header Validity

We define $P(B_H )$ to be the parent block of B
$$
P(H) \equiv B' : KEC(RLP(B'_H)) = H_P
$$
Block number
$$
H_i \equiv P(H)_{H_i} + 1
$$
The canonical difficulty of a block of header H is defined as $D(H)$:
$$
D(H) \equiv \begin{cases} D_0 &\text{ if } H_i = 0 \\
max(D_0, P(H)_{H_d} + x \times s_2 + \epsilon) &\text{ otherwise} \end{cases}
$$
Note that $D_0$ is the difficulty of the genesis block. The `Homestead` difficulty parameter, $s_2$ , is used to affect a dynamic homeostasis of time between blocks, as the time between blocks varies.

In the Homestead release, the exponential difficulty symbol, $\epsilon$ causes the difficulty to slowly increase (every 100,000 blocks) at an exponential rate, and thus increasing the block time difference, and putting time pressure on transitioning to proof-of-stake. This effect, known as the “difficulty bomb”, or “ice age”, was explained in EIP-649 by Schoedon and Buterin [2017] and delayed and implemented earlier in EIP-2.

$s_2$ was also modified in EIP-100 with the use of $x$, the adjustment factor above, and the denominator 9, in order to target the mean block time including uncle blocks by Buterin [2016]. ***Finally, in the Byzantium release, with EIP-649, the ice age was delayed by creating a fake block number, $H'_{i_0}$,*** which is obtained by subtracting three million from the actual block number, which in other words reduced $\epsilon$ and the time difference between blocks, in order to allow more time to develop proof-of-stake and preventing the network from “freezing” up.

The nonce $H_n$ must satisfy the relations
$$
n \leqslant \frac{2^{256}}{H_d} \wedge \  m = H_m
$$
with 
$$
(n, m) = PoW(H_\cancel{n}, H_n, d)
$$

> $H_n$ : nonce
>
> $H_m$ : mix-hash

***Where $H_n$ is the new block’s header $H$, but without the nonce and mix-hash components,*** $d$ being the current DAG, a large data set needed to compute the mix-hash, and PoW is the proof-of-work function. This evaluates to an array with the first item being the mix-hash, to prove that a correct DAG has been used, and the second item being a pseudo-random number cryptographically dependent on $H$ and $d$. Given an approximately uniform distribution in the range [0, $2^{64}$ ), the expected time to find a solution is proportional to the difficulty, $H_d$.

## 5. Gas And Payment

In order to avoid issues of network abuse and to sidestep the inevitable questions stemming from Turing complete-
ness, all programmable computation in Ethereum is subject to fees. The fee schedule is specified in units of gas. Thus any given fragment of programmable computation has a universally agreed cost in terms of gas.

Every transaction has a specific amount of gas associated with it:`gasLimit`. This is the amount of gas which is implicitly purchased from the sender’s account balance. The purchase happens at the according `gasPrice`, also specified in the transaction. The transaction is considered invalid if the account balance cannot support such a purchase. It is named `gasLimit` since any unused gas at the end of the transaction is refunded to the sender’s account. Gas does not exist outside of the execution of a transaction. Thus for accounts with trusted code associated, a relatively high gas limit may be set and left alone.

In general, Ether used to purchase gas that is not refunded is delivered to the beneficiary address, the address of an account typically under the control of the miner. Transactors are free to specify any `gasPrice` that they wish, however miners are free to ignore transactions as they choose. Since there will be a (weighted) distribution of minimum acceptable gas prices, transactors will necessarily have a trade-off to make between lowering the gas price and maximising the chance that their transaction will be mined in a timely manner.

> Block gas limit가 정해져 있기 때문에 gas price가 높으면 더 많은 수수로 얻을 수 있음.

## 6. Transaction Execution

The execution of a transaction is the most complex part of the Ethereum protocol:

It is assumed that any transactions executed first pass the initial tests of intrinsic validity.

- The transaction is well-formed RLP, with no additional trailing bytes
- the transaction signature is valid
- the transaction nonce is valid (equivalent to the sender account’s current nonce)
- the gas limit is no smaller than the intrinsic gas, $g_0$, used by the transaction
- the sender account balance contains at least the cost, $v_0$, required in up-front payment.

$$
\sigma ^{'} = \gamma(\sigma, T)
$$

- $\sigma ^{'}$  is post-transaction state.
- $\gamma^{g}$ : to evaluate to the amount of gas used in the excution of a transaction
- $\gamma^{l}$ : to evaluate to the transaction's accrued(발생한) log time
- $\gamma^{z}$ : to evaluate to the status code resulting from the transaction.

### 6.1 Substate

Throughout transaction execution, we accrue certain information that is acted upon immediately following the transaction. We call this transaction substate, and represent it as `A`,
$$
A \equiv (A_s, A_l, A_t, A_r)
$$

- $A_s$ the self-destruct set: a set of accounts that will be discarded following the transaction’s completion.
- $A_l$ is the log series: this is a series of archived and indexable ‘checkpoints’ in VM code execution that allow for contract-calls to be easily tracked by onlookers external to the Ethereum world (such as decentralised application front-ends).
- $A_t$ is the set of touched accounts, of which the empty ones are deleted at the end of a transaction.
- $A_r$, the refund balance, increased through using the SSTORE instruction in order to reset contract storage to zero from some non-zero value.
- $A^0$ : empty substate

$$
A^0 \equiv (\empty, (), \empty, 0)
$$

### 6.2 Execution

The execution of a valid transaction begins with an irrevocable(변경할 수 없는) change made to the state: the nonce of the account of the sender, `S(T)`, is incremented by one and the balance is reduced.

## 7. Contract creation

There are a number of intrinsic parameters used when creating an account:

- sender (s)
- original transactor (o)
- available gas (g)
- gas price (p)
- endowment(기부금, 자질) (v) together with an arbitrary length byte array
- the initialisation EVM code `i`
- the present depth of the message-call/contract-creation stack (e)
- the permission to make modifications to the state (w).

We define the creation function formally as the function $\wedge$, which evaluates from these values, together with the state σ to the tuple containing the new state, remaining gas, accrued transaction substate and an error message
$(σ', g', A, o)$, as in section 6:
$$
{\sigma^{'}, g', A, z, o} \equiv \wedge(\sigma, s, o, g, p, v, i, e, w)
$$
The address of the new account is defined as being the rightmost 160 bits of the Keccak hash of the RLP encoding of the structure containing only the sender and the account nonce. Thus we define the resultant address for the new account $\alpha$:
$$
\alpha \equiv \beta_{96..255}(KEC(RLP(s, \sigma[s]_n - 1)))
$$
***Note we use one fewer than the sender’s nonce value;*** we assert that we have incremented the sender account’s nonce prior to this call, and so the value used is the sender’s nonce at the beginning of the responsible transaction or VM operation.

## 11. Block Finalization

The process of finalising a block involves four stages:

​	(1) Validate (or, if mining, determine) ommers;
​	(2) validate (or, if mining, determine) transactions;
​	(3) apply rewards;
​	(4) verify (or, if mining, compute a valid) state and block nonce.

### 11.1 Omar Validation

The validation of ommer headers means nothing more than verifying that ***each ommer header is both a valid header and satisfies the relation of N th-generation ommer to the present block where N ≤ 6.*** The maximum of ommer headers is two.

### 11.2 Transaction Validation

The given `gasUsed` must correspond faithfully to the transactions listed: $B_{H_g}$,the total gas used in the block, must be equal to the accumulated gas used according to the final transaction:

### 11.3 Reward Application

The application of rewards to a block involves raising the balance of the accounts of the beneficiary address of the block and each ommer by a certain amount. We raise the block's beneficiary account by $R_{block}$; for each ommer, we raise the block's beneficiary $\frac{1}{32}$ by an additional of the block reward and the beneficiary of the ommer gets rewarded depending on the block number. Formally we define the function Ω:

> beneficiary : 수익자

If there are collisions of the beneficiary addresses between ommers and the block (i.e. two ommers with the same beneficiary address or an ommer with the same beneficiary address as the present block), additions are applied
cumulatively.

### 11.5 Mining Proof-of-Work

For both reasons, there are two important goals of the proof-of-work function;

- Firstly, it should be as accessible as possible to as many people as possible. The requirement of, or reward from, specialised and uncommon hardware should be minimised. This makes the distribution model as open as possible, and, ideally, makes the act of mining a simple swap from electricity to Ether at roughly the same rate for anyone around the world.
- Secondly, it should not be possible to make super-linear profits, and especially not so with a high initial barrier. Such a mechanism allows a well-funded adversary to gain a troublesome amount of the network's total mining power and as such gives them a super-linear reward (thus skewing distribution in their favour) as well as reducing the network security.

Two directions exist for ASIC resistance;

- Firstly make it sequential memory-hard, i.e. engineer the function such that the determination of the ***nonce requires a lot of memory and bandwidth such that the memory cannot be used in parallel to discover multiple nonces simultaneously.***
- The second is to make the type of computation it would need to do general-purpose; the meaning of “specialised hardware” for a general-purpose task set is, naturally, general purpose hardware and as such commodity desktop computers are likely to be pretty close to “specialised hardware” for the task. ***For Ethereum 1.0 we have chosen the first path.***

#### 11.5.1 Ethash

- There exists a seed which can be computed for each block by scanning through the block headers up until that point.
- From the seed, one can compute a pseudo-random cache, $J_{cacheinit}$ bytes in initial size. Light clients store the cache.
- From the cache, we can generate a dataset, $J_{datasetinit}$ bytes in initial size, with the property that each item in the dataset depends on only a small number of items from the cache. Full clients and miners store the dataset. The dataset grows linearly with time.
- Mining involves grabbing random slices of the dataset and hashing them together. Verification can be done with low memory by using the cache to regenerate the specific pieces of the dataset that you need, so you only need to store the cache.
- The large dataset is updated once every $J_{epoch}$ blocks, so the vast majority of a miner's effort will be reading the dataset, not making changes to it.

