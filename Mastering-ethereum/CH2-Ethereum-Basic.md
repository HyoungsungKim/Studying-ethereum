## CH2 Ethereum Basic

## Ether Currency Units

Ethereum’s currency unit is called *ether*, identified also as "ETH" or with the symbols

Ether is subdivided into smaller units, down to the smallest unit possible, which is named *wei*. One ether is 1 quintillion wei (1 * 10^18 or 1,000,000,000,000,000,000).

***Ethereum is the system, ether is the currency.***

## Choosing an Ethereum Wallet

 Ethereum wallet is your gateway to the Ethereum system.

***Remember that for a wallet application to work, it must have access to your private keys***, so it is vital that you only download and use wallet applications from sources you trust.

## Control and Responsibility

Open blockchains like Ethereum are important because they operate as a *decentralized* system.

## Getting Started

### Switching Networks

- Main Ethereum Network
- Ropsten Test Network
- Kovan Test Network
- Rinkeyby Test Network
- Localhost 8545
- Custom RPC

## Introducing to the World Computer

In fact, the cryptocurrency function is  subservient to Ethereum’s function as a decentralized world computer.  Ether is meant to be used to pay for running *smart contracts*, which are computer programs that run on an emulated computer called the *Ethereum Virtual Machine* (EVM).

The EVM is a global singleton, meaning that it operates as if it were a global, single-instance computer, running everywhere. ***Each node on the Ethereum network runs a local copy of the EVM to validate contract execution, while the Ethereum blockchain records the changing state of this world computer as it processes transactions and smart contracts.***

## Externally Owned Accounts(EOAs) and Contracts

- The type of account you created in the MetaMask wallet is called an *externally owned account* (EOA). 

***Externally owned accounts are those that have a private key***;  having the private key means control over access to funds or contracts.

- That other type of account is a *contract account*.

***A contract  account has smart contract code, which a simple EOA can’t have.***  Furthermore, a contract account does not have a private key. Instead, ***it is owned (and controlled) by the logic of its smart contract code***: the software program recorded on the Ethereum blockchain at the contract account’s creation and executed by the EVM.

***Contracts have addresses, just like EOAs. Contracts can also send and receive ether, just like EOAs. However, when a transaction destination is a contract address***, it causes that contract to *run* in the EVM, using the transaction, and the transaction’s data, as its input. 

In addition to ether, ***transactions can contain data indicating which specific function in the contract to run and what parameters to pass to that function.*** In this way, transactions can *call* functions within contracts.

Note that because a contract account does not have a private key, it cannot *initiate* a transaction. Only EOAs can initiate transactions, but contracts can *react* to transactions by calling other contracts, building complex execution paths.

A typical DApp programming pattern is to have Contract A calling Contract B in order to maintain a shared state across users of Contract A.

## A Simple Contract:A Test Ether Faucet

The first smart contract which has *flaw*

```solidity
contract Faucet {
    function withdraw(uint withdraw_amout) public {
        require(withdraw_amout <= 100000000000000000);
        msg.sender.transfer(withdraw_amout);
    }
    function () external payable {}
}
```

Registering a contract on the blockchain involves creating a special transaction whose destination is the address 0x0000000000000000000000000000000000000000, also known as the *zero address*. ***The zero address is a special address that tells the Ethereum blockchain that you want to register a contract.***

## Interacting with the Contract

- Ethereum contracts are programs that control money, which run inside a virtual machine called the EVM.
- They are created by a special transaction that submits their bytecode to be recorded on the blockchain.
- ***Once they are created on the blockchain, they have an Ethereum address, just like wallets.*** Anytime someone sends a transaction to a contract address it causes the contract to run in the EVM, with the transaction as its input.
- Transactions sent to contract addresses may have ether or data or both. If they contain ether, it is "deposited" to the contract balance. If they contain data, the data can specify a named function in the contract and call it, passing arguments to the function.

```solidity
function () external payable{}
```

***When you sent a transaction to the contract address, with no data specifying which function to call, it called this default function.*** Because we declared it as payable, it accepted and deposited the 1 ether into the contract’s account balance. Your transaction caused the contract to run in the EVM, updating its balance. You have funded your faucet!