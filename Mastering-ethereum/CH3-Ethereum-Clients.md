# CH3 Ethereum Clients

***An Ethereum client is a software application that implements the Ethereum specification and communicates over the peer-to-peer network with other Ethereum clients.*** 

While these different clients are implemented by different teams and in different programming languages, they all "speak" the same protocol and follow the same rules. As such, they can all be used to operate and interact with the same Ethereum network

## Ethereum Networks

There exist a variety of Ethereum-based networks that largely conform to the formal specification defined in the Ethereum Yellow Paper, but  which may or may not interoperate with each other.

Currently, there are six main implementations of the Ethereum protocol, written in six different languages:

- Parity, written in Rust
- Geth, written in Go
- cpp-ethereum, written in C++
- pyethereum, written in Python
- Mantis, written in Scala
- Harmony, written in Java

### Should i Run a Full Node?

A full node running on a live *mainnet* network is not necessary for Ethereum development. You can do almost everything you need to do with a *testnet* node (which connects you to one of the smaller public test blockchains), with a local private blockchain like Ganache, or with a cloud-based Ethereum client offered by a service provider like Infura.

The terms "remote client" and "wallet" are used interchangeably, though there are some differences. Usually, a remote client offers an API (such as the web3.js API) in addition to the transaction functionality of a wallet.

***Do not confuse the concept of a remote wallet in Ethereum with that of a light client (which is analogous to a Simplified Payment Verification client in Bitcoin)***. Light clients validate block headers and use Merkle proofs to validate the inclusion of transactions in the blockchain and determine their effects, giving them a similar level of security to a full node. 
***Conversely, Ethereum remote clients do not validate block headers or transactions.*** They entirely trust a full client to give them access to the blockchain, and hence lose significant security and anonymity guarantees.

## Running an Ethereum Client

### Go-Ethereum(Geth)

***Geth is the Go language implementation that is actively developed by the Ethereum Foundation, so is considered the "official" implementation of the Ethereum client.*** Typically, every Ethereum-based blockchain will have its own Geth implementation.

