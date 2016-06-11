This tutorial will guide you through a demo token system.
We will use [Dapple](http://dapple.readthedocs.io/en/latest/)
to build, test and deploy our contracts.

## Installing Dapple and the Solidity compiler

First of all, make sure you have Node.js version 5.0 or later:

    $ node --version
    v6.0.0

Now install Dapple using npm:

    $ npm install -g dapple

Although this is sufficient to start developing smart contracts, we highly
recommend that you install the native Solidity compiler as well
([instructions](https://solidity.readthedocs.org/en/latest/installing-solidity.html)).
While not strictly necessary, the Solidity compiler written in JavaScript
which is bundled with Dapple is very slow and may have other problems.

In order to deploy your contracts to the Ethereum testnet or mainnet,
you will need a running Ethereum RPC endpoint, such as provided by `geth`
([instructions](https://github.com/ethereum/go-ethereum/wiki/Building-Ethereum)).

If you want to use some of the more advanced features of Dapple, you will
also need to install IPFS ([instructions](https://ipfs.io/docs/install/)).

## Configuring Dapple

After you've installed everything, it's time to configure Dapple.
Running `dapple config` will guide you through the setup process and
create a `~/.dapplerc` file in your home directory.  This file contains
information about how to connect to the Ethereum RPC and IPFS endpoints.

## Starting your Ethereum node

When experimenting with deploying contracts, you will want to use the
non-production network meant for testing (known as "Morden"), which is
done by giving the `--testnet` option to `geth`:

    $ geth --testnet account new
    $ geth --testnet --rpc --unlock 0

The second command starts an Ethereum node for Morden with an RPC server
listening on `localhost:8545` (the default port), and the first account
unlocked so that you are able to sign and publish transactions from it.

Finally, you will need some ether in order to pay the gas cost of
deploying contracts or publishing other transactions from your account.

You can get free ether for Morden here: http://faucet.ma.cx:3000/
