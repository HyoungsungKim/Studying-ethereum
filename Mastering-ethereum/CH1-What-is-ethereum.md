# CH1 What is Ethereum?

Ethereum is often described as ***"the world computer"***

- Computer science perspective

Ethereum is a deterministic but practically unbounded state machine,  consisting of a globally accessible singleton state and a virtual  machine that applies changes to that state.

> singleton : 애플리케이션이 시작 될 때 어떤 클래스가 최초 한번만 메모리를 할당하고 그 메모리에 인스턴스를 만들어 사용하는 디자인 패턴.

- practical perspective

Ethereum is an open source, globally decentralized computing infrastructure that executes programs called *smart contracts*. It uses a blockchain to synchronize and store the system’s state changes, along with a cryptocurrency called *ether* to meter and constrain execution resource costs.

## Compared to Bitcoin

Yet in many ways, both the purpose and construction of Ethereum are strikingly different from those of the open blockchains that preceded it, including Bitcoin.

***Ethereum’s purpose is not primarily to be a digital currency payment network.***

 Ethereum’s language is *Turing complete*, meaning that Ethereum can straightforwardly function as a general-purpose computer.

## Component of a Blockchain

- A game-theoretically sound incentivization scheme (e.g., proof-of-work  costs plus block rewards) to economically secure the state machine in an open environment

***In Ethereum, rather than a reference implementation there is a reference specification, a mathematical description of the system in the Yellow Paper.*** There are a number of clients, which are built according to the reference specification.

## Ethereum’s Four Stages of Development

***Ethereum’s development was planned over four distinct stages, with major changes occurring at each stage. A stage may include subreleases, known as "hard forks," that change functionality in a way that is not backward compatible.***

The four main development stages are codenamed 

- *Frontier*
- *Homestead*
- *Metropolis* 
- *Serenity*

The intermediate hard forks that have occurred (or are planned) to date are codenamed 

- *Ice Age*
- *DAO*
- *Tangerine Whistle*
- *Spurious Dragon*
- *Byzantium* : Byzantium is the first of two hard forks planned for Metropolis.

- *Constantinople*

## Ethereum: A General-Purpose Blockchain

You can think of Bitcoin as a distributed consensus *state machine*, where transactions cause a global *state transition*, altering the ownership of coins. 

The state transitions are constrained by the rules of consensus, allowing all participants to (eventually) converge on a common (consensus) state of the system, after several blocks are mined.

***Ethereum is also a distributed state machine.*** But instead of tracking only the state of currency ownership, ***Ethereum tracks the state transitions of a general-purpose data store, i.e., a store that can hold any data expressible as a key–value tuple.***

***Ethereum has memory that stores both code and data***, and it uses the Ethereum blockchain to track how this memory changes over time. Like a general-purpose stored-program computer, Ethereum can load code into its state machine and *run* that code, storing the resulting state changes in its blockchain.

## Ethereum's Components

***State machine***

Ethereum state transitions are processed by the *Ethereum Virtual Machine* (EVM), a stack-based virtual machine that executes *bytecode*  (machine-language instructions). EVM programs, called "smart  contracts," are written in high-level languages (e.g., Solidity) and  compiled to bytecode for execution on the EVM.

***Data structures***

Ethereum’s state is stored locally on each node as a *database* (usually Google’s LevelDB), which contains the transactions and system state in a serialized hashed data structure called a *Merkle Patricia Tree*.

## Ethereum and Turing Completeness

 Ethereum, they say, unlike Bitcoin, is Turing complete. 

Alan Turing further defined a system to be ***Turing complete if it can be used to simulate any Turing machine. Such a system is called a Universal Turing machine (UTM).***

Ethereum can compute any algorithm that can be computed by any Turing machine, given the limitations of finite memory.

Ethereum’s groundbreaking innovation is to combine the general-purpose computing architecture of a stored-program computer with a decentralized blockchain, thereby creating a distributed single-state (singleton) world computer. 

### Turing Completeness as a "Feature"

Turing completeness is very dangerous, particularly in open access systems like public blockchains, because of the halting problem we touched on earlier.

The fact that Ethereum is Turing complete means that any program of any complexity can be computed by Ethereum. But that flexibility brings some thorny security and resource management problems. An unresponsive printer can be turned off and turned back on again. That is not possible with a public blockchain.

### Implications of Turing Completeness

Turing proved that you cannot predict whether a program will terminate by simulating it on a computer. Turing-complete systems can run in "infinite loops," a term used (in oversimplification) to describe a program that does not terminate. 

As Turing proved, Ethereum can’t predict if a smart contract will terminate, or how long it will run, without actually running it (possibly running forever). 

***Ethereum introduces a metering mechanism called gas.*** 

As the EVM executes a smart contract, it carefully accounts for every  instruction. Each instruction has a  predetermined cost in units of gas. The EVM will terminate execution if the amount of gas consumed by computation exceeds the gas available in the transaction. ***Gas is the mechanism Ethereum uses to allow Turing-complete computation while limiting the resources that any program can consume.***

how does one get gas to pay for computation on the Ethereum world computer?

- It can only be purchased as part of a transaction
- It can only be bought with ether.

## From General-Purpose Blockchains to Decentralized Applications (DApps)

Ethereum started as a way to make a general-purpose blockchain that could be programmed for a variety of uses. ***But very quickly, Ethereum’s vision expanded to become a platform for programming DApps.*** 

- DApps represent a broader perspective than smart contracts.
- A DApp is, at the very least, a smart contract and a web user interface.
- More broadly, a ***DApp is a web application that is built on top of open, decentralized, peer-to-peer infrastructure services.***

A DApp is composed of at least:

- Smart contracts on a blockchain
- A web frontend user interface

## The Third Age of the Internet

The concept of DApps is meant to take the World Wide Web to its next natural evolutionary stage, introducing decentralization with peer-to-peer protocols into every aspect of a web application. 

 The term used to describe this evolution is *web3*, meaning the third "version" of the web. 

### Ethereum's Development Culture

In Bitcoin, development is guided by conservative principles

In Ethereum, by comparison, the community’s development culture is focused on the future rather than the past. 

What this means to you as a developer is that you must remain flexible and be prepared to rebuild your infrastructure as some of the underlying assumptions change. ***One of the big challenges facing developers in Ethereum is the inherent contradiction between deploying code to an immutable system and a development platform that is still evolving.***

> contradiction : 모순
>
> deploy : 전개하다