# Ethereum Architecture

## What is Ethereum

***The World computer*** 

- Computer science

***Unbounded state machine***, singleton state and a virtual machine

- Practical Analysis

Decentralized computing  infrastructure that executes programs called smart contracts

## Turing Complete



## Ethereum Accounts

- Externally owned accounts(EOAs)

- Contract account(CA)

CA is worked by EOA -> cannot be pulled triggered alone

## Ethereum architecture

There is a state root so value can be changed  by using contract

-> state is not in block

Don't use UTXO so Double spending attack can be happened

-> nonce is used to prevent it(It is different with bitcoin's nonce)

Bitcoin

- Use UTXO
- Using levelDB -> UTXO set
- Multiple transaction input

Ethereum

- none-UTXO
- Account balance
- Like Bank account funds

## Ethereum network

- Mainnet
- Testnet
  - Ropsten
  - kovan
  - Rinkeby
- Private
  - Geth
  - Ganache

## Dapp Development

There is no authentication in RPC port so it becomes private.

- Etherscan : broadcast transaction, verify smart contract
- Metamask : Ethereum wallet

