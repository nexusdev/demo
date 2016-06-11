This tutorial will guide you through a demo token system. For this we will use
[dapple](http://dapple.readthedocs.io/en/latest/).

## Install

Make sure you have node v5+ installed:
```
$ node --version
v5.0.0
```

The normal way to install Dapple is through npm:

```
$ npm install -g dapple
```

Although this is sufficient to start developing smart contracts, we highly
recommend you to install native **solidity** compiler. You can do so by
following the instructions [here](https://solidity.readthedocs.org/en/latest/installing-solidity.html).
However, this is not necessary as a (slow) javascript compiler is provided along the installation.

If you want to deploy your contracts to the ethereum testnet or mainnet, you
will need a running rpc endpoint. We recommend go-ethereum for this. Following
[this guide](https://github.com/ethereum/go-ethereum/wiki/Building-Ethereum)
will help you set it up.

If you want to use dapples advanced features, you also will need installing
[ipfs](https://ipfs.io/docs/install/) for this.

## Configure dapple

After installing everything its time to configure dapple.
Just run `dapple config` which will guide you through the set-up process and
create a `~/.dapplerc` file in your home-directory containing information about
environments and its ethereum-rpc and ipfs endpoints.

### Start up Ethereum

In order to learn to interact with ethereum we recommend running the ethereums 
testnet "morden" chain. You will also need to create a new account and unlock it on start.
You can get free ether for morden here: http://faucet.ma.cx:3000/
```
$ geth --testnet account new        # create a new account
$ geth --testnet --rpc --verbosity "2" --networkid 2 --unlock 0      # run the rpc client on localhost:8545
```
