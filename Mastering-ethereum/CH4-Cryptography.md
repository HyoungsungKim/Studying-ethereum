# CH4 Cryptography

## Keys and Addresses

Account addresses are derived directly from private keys: a private key uniquely determines a single Ethereum address, also known as an *account*.

***Private keys are not used directly in the Ethereum system in any way; they are never transmitted or stored on Ethereum.*** That is to say that private keys should remain private and never appear in messages passed to the network, nor should they be stored on-chain; ***only account addresses and digital signatures are ever transmitted and stored on the Ethereum system. ***

***Access and control of funds is achieved with digital signatures, which are also created using the private key.*** Ethereum transactions require a valid digital signature to be included in the blockchain. Anyone with a copy of a private key has control of the corresponding account and any ether it holds. users prove ownership of the private key.

Think of the public key as similar to a bank account number, and the private key as similar to the secret PIN;

## Public Key Cryptography and Cryptocurrency

Public key cryptography uses unique keys to secure information. These keys are based on mathematical functions that have a special property: it is easy to calculate them, but hard to calculate their inverse.

***Elliptic curve cryptography is used extensively in modern computer systems and is the basis of Ethereum’s (and other cryptocurrencies') use of private keys and digital signatures***

The mathematics of cryptography provides a way for the message (i.e., the transaction details) to be combined with the private key to create a code that can only be produced with knowledge of the private key. ***That code is called the digital signature.*** Note that an Ethereum transaction is basically a request to access a particular account with a particular Ethereum address.

***When a transaction is sent to the Ethereum network in order to move funds or interact with smart contracts, it needs to be sent with a digital signature created with the private key corresponding to the Ethereum address in question.***

## Private Key

#### Generating a Private Key from a Random Number

The first and most important step in generating keys is to find a secure source of entropy, or randomness. Creating an Ethereum private key essentially involves picking a number between 1 and 2^256. ***Ethereum software uses the underlying operating system’s random number generator to produce 256 random bits.***

```
Example) f8f8a2f43c8376ccb0871305060d7b27b0554d2cc72bccf41b2705608452f315
```

## Public Key

Ethereum public key is two numbers, joined together. It is trivial to calculate a public key if you have the private key, 
but you cannot calculate the private key from the public key.

The public key is calculated from the private key using elliptic curve multiplication, ***which is practically irreversible***: *K* = *k* * *G*, where *k* is the private key, *G* is a constant point called the *generator point*, *K* is the resulting public key, and * is the special elliptic curve "multiplication" operator. ***This is the one-way mathematical function***

***Ethereum uses the exact same elliptic curve, called secp256k1, as Bitcoin. That makes it possible to reuse many of the elliptic curve libraries and tools from Bitcoin.***

#### Elliptic Curve Arithmetic Operations

