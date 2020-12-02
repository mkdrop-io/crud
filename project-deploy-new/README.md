### Overview
---
*Roles* full version.

### Run
---
```bash

$ cd tronbox-rps
$ npm install tronweb

# Shasta env
$ . .env.blank && tronbox console --network ropsten
# or
$ . .env.blank && tronbox console --network mainnet

> migrate --reset
```
#### Deployment summary:
---
### Ropsten

```bash
Starting migrations...
======================
> Network name:    'ropsten'
> Network id:      3
> Block gas limit: 8000000 (0x7a1200)


1_initial_migration.js
======================

   Deploying 'Migrations'
   ----------------------
   > transaction hash:    0x3977e7a8b1c59233a83683a08e8ae6dff346b9002efcd530cdc2af27f7e78b55
   > Blocks: 1            Seconds: 17
   > contract address:    0xC499fB5a3F0AfE6c4B05Cd88BE6fb8f0D30eAAeC
   > block number:        9181722
   > block timestamp:     1606902179
   > account:             0x3A39155F08989f4639f156992F02c744Dc6Cf5E1
   > balance:             4.140722861996329911
   > gas used:            172059 (0x2a01b)
   > gas price:           135 gwei
   > value sent:          0 ETH
   > total cost:          0.023227965 ETH

   Pausing for 2 confirmations...
   ------------------------------
   > confirmation number: 2 (block: 9181724)

   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:         0.023227965 ETH


2_deploy_contracts.js
=====================
--------------------------------------------------------------------------------------------
| Network: ropsten / deployer: 0x3A39155F08989f4639f156992F02c744Dc6Cf5E1 | Balance: 4.135008851996329911 ETH
|----------------------------------------------------------
 Super admin address 0xB0E70D6DD4615Bd74824552675c521489bC5A7D1
 Balance 3.623036183112226721 ETH
|----------------------------------------------------------
 General partner address second 0x01d49981D60766dA64949aeEc0821b60458cbA6b
 Balance 0.495916037999977412 ETH
|----------------------------------------------------------
 Limited partner address third 0x16FFC9a18aEb44462579cF33a1b9A3E95A1a177C
 Balance 0.199475 ETH
|----------------------------------------------------------
 Team address 0xBf239dB73992efEC239eF69c8416255a8422795D
 Balance 1 ETH
|----------------------------------------------------------
 Sturtap team address 0xc30A469379b772dF065F6f52DF89B3FB50E46617
 Balance 0 ETH
|----------------------------------------------------------
 Referer address 0xBf239dB73992efEC239eF69c8416255a8422795D
 Balance 1 ETH
|----------------------------------------------------------

   Deploying 'TestKeysRoles'
   -------------------------
   > transaction hash:    0x26bb0e7d0a6dbace86147fb2c4792135cc3190d1aa68ae633c7980c72a891bb5
   > Blocks: 2            Seconds: 47
   > contract address:    0xb7fc8333b15971C7C8E42fB9668F4E1e6e20F0c4
   > block number:        9181728
   > block timestamp:     1606902285
   > account:             0x3A39155F08989f4639f156992F02c744Dc6Cf5E1
   > balance:             3.861231416996329911
   > gas used:            2027981 (0x1ef1cd)
   > gas price:           135 gwei
   > value sent:          0 ETH
   > total cost:          0.273777435 ETH

   Pausing for 2 confirmations...
   ------------------------------
   > confirmation number: 1 (block: 9181729)
   > confirmation number: 2 (block: 9181730)
--------------------------------------------------------------------
| Admin roles:
--------------------------------------------------------------------
Super admin role   [0xB0E70D6DD4615Bd74824552675c521489bC5A7D1]: false
Super admin role   [0xB0E70D6DD4615Bd74824552675c521489bC5A7D1]: true
--------------------------------------------------------------------
Deployer           [0x3A39155F08989f4639f156992F02c744Dc6Cf5E1]: false
Deployer           [0x3A39155F08989f4639f156992F02c744Dc6Cf5E1]: true
--------------------------------------------------------------------
| Roles:
--------------------------------------------------------------------
General partner    [0x01d49981D60766dA64949aeEc0821b60458cbA6b]: false
General partner    [0x01d49981D60766dA64949aeEc0821b60458cbA6b]: true
--------------------------------------------------------------------
Limited partner    [0x16FFC9a18aEb44462579cF33a1b9A3E95A1a177C]: false
Limited partner    [0x16FFC9a18aEb44462579cF33a1b9A3E95A1a177C]: true
--------------------------------------------------------------------
Team address       [0xBf239dB73992efEC239eF69c8416255a8422795D]: false
Team address       [0xBf239dB73992efEC239eF69c8416255a8422795D]: true
--------------------------------------------------------------------
Sturtap team       [0xc30A469379b772dF065F6f52DF89B3FB50E46617]: false
Sturtap team       [0xc30A469379b772dF065F6f52DF89B3FB50E46617]: true
--------------------------------------------------------------------
Referer            [0xBf239dB73992efEC239eF69c8416255a8422795D]: false
Referer            [0xBf239dB73992efEC239eF69c8416255a8422795D]: true
--------------------------------------------------------------------
--------------------------------------------------------------------
Deployer contract isAdmin:   true
Deployer contract isAdmin:   false

   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:         0.273777435 ETH


Summary
=======
> Total deployments:   2
> Final cost:          0.2970054 ETH
```