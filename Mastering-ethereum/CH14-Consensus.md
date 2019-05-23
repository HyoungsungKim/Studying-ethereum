# CH14 Consensus

In computer science, the term *consensus* predates blockchains and is related to the broader problem of synchronizing state in distributed systems, ***such that different participants in a distributed system all (eventually) agree on a single system-wide state. This is called "reaching consensus."***

> predate : ~보다 먼저 오다

***The lack of a central decision-making entity is one of the main attractions of blockchain platforms,*** because of the resulting capacity to resist censorship and the lack of dependence on authority for permission to access information. However, these benefits come at a cost: without a trusted arbitrator, any disagreements, deceptions, or differences need to be reconciled using other means. ***Consensus algorithms are the mechanism used to reconcile security and decentralization.***

> arbitrator : 중재인

## Consensus via Proof of Work

The creator of the original blockchain, Bitcoin, invented a *consensus algorithm* called *proof of work* (PoW). Arguably, PoW is the most important invention underpinning Bitcoin.

The real purpose of mining (and all other consensus models) is to *secure the blockchain*, while keeping control over the system decentralized and diffused across as many participants as possible.

***Ethereum’s PoW algorithm is slightly different than Bitcoin’s and is called Ethash***

## Consensus via Proof of Stake (PoS)

In some respects, proof of work was invented as an alternative to proof of stake.

> emulate : 흉내내다, 모방하다
>
> resurrect : 부활시키다

There is a deliberate handicap on Ethereum’s proof of work called the *difficulty bomb*, intended to gradually make proof-of-work mining of Ethereum more and more difficult, thereby forcing the transition to proof of stake.

In general, a PoS algorithm works as follows. The blockchain keeps track of a set of validators, and ***anyone who holds the blockchain’s base cryptocurrency (in Ethereum’s case, ether) can become a validator by sending a special type of transaction that locks up their ether into a deposit.***

The validators take turns proposing and voting on the next valid block, and the weight of each validator’s vote depends on the size of its deposit (i.e., stake). 

Importantly, a validator risks losing their deposit if the block they staked it on is rejected by the majority of validators. Conversely, validators earn a small reward, proportional to their deposited stake, for every block that is accepted by the majority. Thus, PoS forces validators to act honestly and follow the consensus rules, by a system of reward and punishment. ***The major difference between PoS and PoW is that the punishment in PoS is intrinsic to the blockchain (e.g., loss of staked ether), whereas in PoW the punishment is extrinsic (e.g., loss of funds spent on electricity).***

## Ethash: Ethereum’s Proof-of-Work Algorithm

Ethash is dependent on the generation and analysis of a large dataset, known as a *directed acyclic graph* (or, more simply, “the DAG”). ***The DAG had an initial size of about 1 GB and will continue to slowly and linearly grow in size, being updated once every epoch (30,000 blocks, or roughly 125 hours).***

***The purpose of the DAG is to make the Ethash PoW algorithm dependent on maintaining a large, frequently accessed data structure.*** This in turn is intended to make Ethash ***"ASIC resistant"*** which means that it is more difficult to make ASIC mining equipment that is orders of magnitude faster than a fast *graphics processing unit* (GPU). 

## Casper: Ethereum’s Proof-of-Stake Algorithm

Casper is the proposed name for Ethereum’s PoS consensus algorithm. Casper is being developed in two competing "flavors":

- Casper FFG: "The Friendly Finality Gadget"
- Casper CBC: "The Friendly GHOST/Correct-by-Construction"

Initially, ***Casper FFG was proposed as a hybrid PoW/PoS algorithm*** to be implemented as a transition to a more permanent "pure PoS" algorithm. But in June 2018, Vitalik Buterin, who was leading the research work on Casper FFG, ***decided to "scrap" the hybrid model in favor of a pure PoS algorithm.*** Now, Casper FFG and Casper CBC are both being developed in parallel.

> scrap : 폐기하다

## 