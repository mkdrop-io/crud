### Overview
---
*Pool Registry*

### Run
---
```bash

$ npm install

NOTE: Edit .env.blank add TRUFFLE_PRIVATE_KEY, change addresses roles

# Kovan env
$ . .env.blank && truffle console --network kovan
# Ropsten env
$ . .env.blank && truffle console --network ropsten
# or
$ . .env.blank && truffle console --network mainnet

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


1_deploy_contracts.js
=====================
--------------------------------------------------------------------------------------------
| Network: ropsten / deployer: 0x3A39155F08989f4639f156992F02c744Dc6Cf5E1 | Balance: 2.828339560349970381 ETH
|----------------------------------------------------------
 Super admin address 0x01d49981D60766dA64949aeEc0821b60458cbA6b
 Balance 0.830970304111058385 ETH
|----------------------------------------------------------
 General partner address second 0x01d49981D60766dA64949aeEc0821b60458cbA6b
 Balance 0.830970304111058385 ETH
|----------------------------------------------------------
 Limited partner address third 0x16FFC9a18aEb44462579cF33a1b9A3E95A1a177C
 Balance 0.199475 ETH
|----------------------------------------------------------
 Team address 0xBf239dB73992efEC239eF69c8416255a8422795D
 Balance 0 ETH
|----------------------------------------------------------
 Sturtap team address 0xc30A469379b772dF065F6f52DF89B3FB50E46617
 Balance 0 ETH
|----------------------------------------------------------
 Referer address 0xBf239dB73992efEC239eF69c8416255a8422795D
 Balance 0 ETH
|----------------------------------------------------------

   Replacing 'PoolRegistry'
   ------------------------
   > transaction hash:    0xa375177207850c4f5db6b3dfc25c5cd6298d812bd14d975109748be3d60dc1d7
   > Blocks: 1            Seconds: 13
   > contract address:    0x2D17F60F550953CCD585b34DCeFD9190c82BB065
   > block number:        9215916
   > block timestamp:     1607363568
   > account:             0x3A39155F08989f4639f156992F02c744Dc6Cf5E1
   > balance:             2.500725100349970381
   > gas used:            5460241 (0x535111)
   > gas price:           60 gwei
   > value sent:          0 ETH
   > total cost:          0.32761446 ETH

   Pausing for 2 confirmations...
   ------------------------------
   > confirmation number: 1 (block: 9215917)
   > confirmation number: 2 (block: 9215918)
--------------------------------------------------------------------
| Admin roles:
--------------------------------------------------------------------
Super admin role   [0x01d49981D60766dA64949aeEc0821b60458cbA6b]: false
Super admin role   [0x01d49981D60766dA64949aeEc0821b60458cbA6b]: true
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
   > Saving artifacts
   -------------------------------------
   > Total cost:          0.32761446 ETH

Summary
=======
> Total deployments:   1
> Final cost:          0.32761446 ETH
```
