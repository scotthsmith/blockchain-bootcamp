# Blockchain Bootcamp

## Day 1

### Introduction

- skills audit (could be done before the course but it's a good way for people to connect to each other)

  - who's written a smart contract before?
  - who's used NodeJS?
  - who's used React
  - who owns any ETH themselves?

- short term pairings

  We will pair up with each other in a rotating fashion so that

  - someone with skills in a topic is paired with someone new to a topic
  - someone in sydney is paired with someone remote
  - pairings will switch regularly.

### Getting set up

- everyone fork the repo

Review the following files.

- `README.md`
- `CONTRIBUTING.md`
- `.gitignore`
- `.circleci/`

### A very simple smart contract

We'll write a very simple contract using [Remix](https://remix.ethereum.org).

#### Outcomes

See examples in [contracts](contracts/).

### Addresses and accounts

- set up an address using MetaMask

  - https://faucet.metamask.io/

- public and private keys

  - everyone saved their passphrases and etc

### EVM 101

ref: https://github.com/ethereum/wiki/wiki/White-Paper

- what's a block?

  - see https://github.com/ethereum/wiki/wiki/Glossary#user-content-ethereum-blockchain

- stack-and-memory model

  - see https://github.com/ethereum/wiki/wiki/Subtleties

- 32 bytes words
- deterministic language
- no i/o
- no external access

    - oracles

      External functions that write data to a smart contract, thus making that data available to other smart contracts.

### Diagrams

![Proof of Work][pow]

![The State Tree][tss]

[pow]: images/proof-of-work.jpg
[tss]: images/the-state-tree.png
