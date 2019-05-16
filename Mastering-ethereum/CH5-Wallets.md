# CH5 Wallets

***The word "wallet" is used to describe a few different things in Ethereum.***

At a high level, a wallet is a software application that serves as the primary user interface to Ethereum. The wallet controls access to a user’s money, managing keys and addresses, tracking the balance, and creating and signing transactions. In addition, some Ethereum wallets can also interact with contracts, such as ERC20 tokens.

More narrowly, from a programmer’s perspective, the word *wallet* refers to the system used to store and manage a user’s keys.  For some wallets, that’s all there is. Other wallets are part of a much broader category, that of *browsers*, which are interfaces to Ethereum-based decentralized applications, or DApps.

## Wallet Technology Overview

A common misconception about Ethereum is that Ethereum wallets contain ether or tokens. In fact, very strictly speaking, the wallet holds only keys. The ether or other tokens are recorded on the Ethereum blockchain.

In a sense, an Ethereum wallet is a *keychain*. Having said that, given that the keys held by the wallet are the only things that are needed to transfer ether or tokens to others, in practice this distinction is fairly irrelevant.

Having said that, given that ***the keys held by the wallet are the only things that are needed to transfer ether or tokens to others, in practice this distinction is fairly irrelevant.*** In practice this means that there is an independent way to check an account’s balance, without needing its wallet. Moreover, you can move your account handling from your current wallet to a different wallet, if you grow to dislike the wallet app you started out using.

There are two primary types of wallets, distinguished by whether the keys they contain are related to each other or not.

- ***The first type is a nondeterministic wallet, where each key is independently generated from a different random number. The keys are not related to each other.*** This type of wallet is also known as a JBOK wallet, from the phrase "Just a Bunch of Keys.”
- ***The second type of wallet is a deterministic wallet, where all the keys are derived from a single master key, known as the seed. All the keys in this type of wallet are related to each other and can be generated again if one has the original seed.*** There are a number of different *key derivation* methods used in deterministic wallets. The most commonly used derivation method uses a ***tree-like structure***, as described in Hierarchical Deterministic Wallets (BIP-32/BIP-44)

## Wallet Best Practice

These standards may change or be obsoleted by future developments, but for now they form a set of interlocking technologies that have become the *de facto* wallet standard for most blockchain platforms and their cryptocurrencies.

