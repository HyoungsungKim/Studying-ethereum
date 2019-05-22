# CH7 Smart Contract and Solidity

There are two different types of accounts in Ethereum: ***externally owned accounts (EOAs) and contract accounts.***

EOA

- ***EOAs*** are controlled by users, often via software such as a wallet application that is external to the Ethereum platform.
- EOAs are simple accounts without any associated code or data storage
-  EOAs are controlled by transactions created and cryptographically signed with a private key in the "real world" external to and independent of the protocol\

Contract account

- In contrast, ***contract accounts*** are controlled by program code (also commonly referred to as “smart contracts”) that is executed by the Ethereum Virtual Machine. 
- contract accounts have both associated code and data storage.
- contract accounts do not have private keys and so "control themselves" in the predetermined way prescribed by their smart contract code.

***Both types of accounts are identified by an Ethereum address.***

## What is a smart contract?

Nick Szabo coined the term and defined it as “a set of promises, specified in digital form, including protocols within which the parties perform on the other promises.” 

In the context of Ethereum, the term is actually a bit of a misnomer, given that Ethereum smart contracts are neither smart nor legal contracts.

## Life Cycle of a Smart Contract

Smart contracts are typically written in a high-level language, such as Solidity. But in order to run, they must be compiled to the low-level bytecode that runs in the EVM. 

The Ethereum address of a contract can be used in a transaction as the recipient, sending funds to the contract or calling one of the contract’s functions. ***Note that, unlike with EOAs, there are no keys associated with an account created for a new smart contract.*** As the contract creator, you don’t get any special privileges at the protocol level (although you can explicitly code them into the smart contract). ***You certainly don’t receive the private key for the contract account, which in fact does not exist—we can say that smart contract accounts own themselves.***

>  스마트 컨트랙트 내부에 만든 사람이 우선권을 얻기 위한 코드가 없으면 우선권을 얻을 수 없음

***Importantly, contracts only run if they are called by a transaction***. All smart contracts in Ethereum are executed, ultimately, ***because of a transaction initiated from an EOA.*** A contract can call another contract that can call another contract, and so on, but the first contract in such a chain of execution will always have been called by a transaction 
from an EOA. Contracts never run “on their own” or “in the background”. ***It is also worth noting that smart contracts are not executed "in parallel" in any sense—the Ethereum world computer can be considered to be a single-threaded machine.***

> noting : 주석을 달다, 적어두다.
>
> smart contracts are not executed in parallel -> It means if 100 people want to execute smart contrast, then they have to wait...?
>
> or single thread means there is a procedure for executing smart contracts?

***Transactions are atomic, regardless of how many contracts they call or what those contracts do when called.*** Transactions execute in their entirety, with any changes in the global state (contracts, accounts, etc.) recorded only if all execution terminates successfully. ***Successful termination means that the program executed without an error and reached the end of execution.***

***If execution fails due to an error, all of its effects (changes in state) are “rolled back” as if the transaction never ran. A failed transaction is still recorded as having been attempted, and the ether spent on gas for the execution is deducted from the originating account, but it otherwise has no other effects on contract or account state.***

> atomic : 독립 요소로 분해될 수 없는 속성

As mentioned previously, it is important to remember that a contract’s code cannot be changed. ***However, a contract can be “deleted,” removing the code and its internal state (storage) from its address, leaving a blank account.*** 

***To delete a contract, you execute an EVM opcode called SELFDESTRUCT (previously called SUICIDE). That operation costs “negative gas,” a gas refund, thereby incentivizing the release of network client resources from the deletion of stored state.*** Deleting a contract in this way does not remove the transaction history (past) of the contract, since the blockchain itself is immutable. ***It is also important to note that the SELFDESTRUCT capability will only be available if the contract author programmed the smart contract to have that functionality.*** If the contract’s code does not have a SELFDESTRUCT opcode, or it is inaccessible, the smart contract cannot be deleted.

## Introduction to Ethereum High-Level Language

Most Ethereum developers use a high-level language to write programs, and a compiler to convert them into bytecode.

## Building a Smart Contract with Solidity

### Selecting a Version of Solidity

Solidity follows a versioning model called *semantic versioning*, which specifies version numbers structured as three numbers separated by dots: *MAJOR.MINOR.PATCH*. The "major" number is incremented for major and *backward-incompatible* changes, the "minor" number is incremented as backward-compatible features are added in between major releases, and the "patch" number is incremented for backward-compatible bug fixes.

## The Ethereum Contract ABI

In computer software, an *application binary interface* is an interface between two program modules; often, between the operating system and user programs. An ABI defines how data structures and functions are accessed in *machine code*; this is not to be confused with an API, which defines this access in high-level, often human-readable formats as *source code*. ***The ABI is thus the primary way of encoding and decoding data into and out of machine code.***

All that is needed for an application to interact with a contract is an ABI and the address where the contract has been deployed.

### Selecting a Solidity Compiler and Language Version

To resolve such issues, Solidity offers a *compiler directive* known as a *version pragma* that instructs the compiler that the program expects a specific compiler (and language) version. Let’s look at an example:

```solidity
pragma solidity ^0.4.19;
```

## Programming with Solidity

### Contract Constructor and selfdestruct

There is a special function that is only used once. When a contract is created, it also runs the *constructor function*
if one exists, to initialize the state of the contract. The constructor is run in the same transaction as the contract creation. ***The constructor function is optional.***

```solidity
contract MEContract {
	function MEContract() {
		...
	}
}
// OR
contract MEContact {
	constructor() {
		...
	}
}

```

Contracts are destroyed by a special EVM opcode called SELFDESTRUCT. In Solidity, this opcode is exposed as a high-level built-in function called selfdestruct

```solidity
selfdestruct(address recipient);
```

### Adding a Constructor and selfdestruct to Our Faucet Example

