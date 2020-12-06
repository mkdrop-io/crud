### Overview
---
*Investment pool* full version.

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


2_deploy_contracts.js
=====================
--------------------------------------------------------------------------------------------
| Network: ropsten / deployer: 0x3A39155F08989f4639f156992F02c744Dc6Cf5E1 | Balance: 3.220209505443065678 ETH
|----------------------------------------------------------
 Super admin address 0xB0E70D6DD4615Bd74824552675c521489bC5A7D1
 Balance 3.612381595463695739 ETH
|----------------------------------------------------------
 General partner address second 0x01d49981D60766dA64949aeEc0821b60458cbA6b
 Balance 0.495784730999977412 ETH
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

   Replacing 'InvestmentPool'
   --------------------------
   > transaction hash:    0x7c44f285b0cc85d76129ea9ed697b92bf1ca55873cce69210cd52e2d9bb371dd
   > Blocks: 2            Seconds: 17
   > contract address:    0x8b210028367Ed2ec5008A330D7d7F0aFD27b1837
   > block number:        9209062
   > block timestamp:     1607273725
   > account:             0x3A39155F08989f4639f156992F02c744Dc6Cf5E1
   > balance:             2.797586065443065678
   > gas used:            3130544 (0x2fc4b0)
   > gas price:           135 gwei
   > value sent:          0 ETH
   > total cost:          0.42262344 ETH

   Pausing for 2 confirmations...
   ------------------------------
   > confirmation number: 1 (block: 9209064)
   > confirmation number: 2 (block: 9209065)
--------------------------------------------------------------------
--------------------------------------------------------------------
Investment Pool address:   0x8b210028367Ed2ec5008A330D7d7F0aFD27b1837
Token address:             0x01d49981D60766dA64949aeEc0821b60458cbA6b
Locked:                    1
Rate:                      2
Interest fee:              3
Anual precent:             4
--------------------------------------------------------------------
--------------------------------------------------------------------
Deployer contract isAdmin:   true
Deployer contract isAdmin:   false
   > Saving artifacts
   -------------------------------------
   > Total cost:          0.42262344 ETH


Summary
=======
> Total deployments:   1
> Final cost:          0.42262344 ETH
```
