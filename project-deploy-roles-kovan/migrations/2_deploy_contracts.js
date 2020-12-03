const HDWalletProvider = require("@truffle/hdwallet-provider");
const Web3 = require("web3");

const {
  TRUFFLE_PRIVATE_KEY,
  SUPER_ADMIN_ADDRESS,
  GENERAL_PARTNER_ADDRESS,
  LIMITED_PARTNER_ADDRESS,
  TEAM_ADDRESS,
  STURTAP_TEAM_ADDRESS,
  REFERER_ADDRESS,
  ORACLE_ADDRESS
} = process.env;

// const provider = new HDWalletProvider(
//   TRUFFLE_PRIVATE_KEY,
//   `https://mainnet.infura.io/v3/9f455763426b46e68c3ef87e37b429c1`
// );

// const provider = new HDWalletProvider(
//   TRUFFLE_PRIVATE_KEY,
//   `https://ropsten.infura.io/v3/9f455763426b46e68c3ef87e37b429c1`
// );

const provider = new HDWalletProvider(
  TRUFFLE_PRIVATE_KEY,
  `https://kovan.infura.io/v3/9f455763426b46e68c3ef87e37b429c1`
);

const web3 = new Web3(provider);

const SUPER_ADMIN_ROLE = web3.utils.sha3("SUPER_ADMIN_ROLE");
const GENERAL_PARTNER_ROLE = web3.utils.sha3("GENERAL_PARTNER_ROLE");
const LIMITED_PARTNER_ROLE = web3.utils.sha3("LIMITED_PARTNER_ROLE");
const TEAM_ROLE = web3.utils.sha3("TEAM_ROLE");
const STURTAP_TEAM_ROLE = web3.utils.sha3("STURTAP_TEAM_ROLE");
const REFERER_ROLE = web3.utils.sha3("REFERER_ROLE");

const TestKeysRoles = artifacts.require("TestKeysRoles");

module.exports = function (deployer, network, accounts) {
  deployer.then(async () => {
    try {
      console.log('--------------------------------------------------------------------------------------------');

      const balanceDeployerStart = web3.utils.fromWei(await web3.eth.getBalance(accounts[0]), 'ether');
      console.log(`| Network: ${network} / deployer: ${accounts[0]} | Balance: ${balanceDeployerStart} ETH`);

      console.log(`|----------------------------------------------------------`);
      console.log(` Super admin address ${SUPER_ADMIN_ADDRESS}`);
      console.log(` Balance ${web3.utils.fromWei(await web3.eth.getBalance(SUPER_ADMIN_ADDRESS), 'ether')} ETH`);
      console.log(`|----------------------------------------------------------`);
      console.log(` General partner address second ${GENERAL_PARTNER_ADDRESS}`);
      console.log(` Balance ${web3.utils.fromWei(await web3.eth.getBalance(GENERAL_PARTNER_ADDRESS), 'ether')} ETH`);
      console.log(`|----------------------------------------------------------`);
      console.log(` Limited partner address third ${LIMITED_PARTNER_ADDRESS}`);
      console.log(` Balance ${web3.utils.fromWei(await web3.eth.getBalance(LIMITED_PARTNER_ADDRESS), 'ether')} ETH`);
      console.log(`|----------------------------------------------------------`);
      console.log(` Team address ${TEAM_ADDRESS}`);
      console.log(` Balance ${web3.utils.fromWei(await web3.eth.getBalance(TEAM_ADDRESS), 'ether')} ETH`);
      console.log(`|----------------------------------------------------------`);
      console.log(` Sturtap team address ${STURTAP_TEAM_ADDRESS}`);
      console.log(` Balance ${web3.utils.fromWei(await web3.eth.getBalance(STURTAP_TEAM_ADDRESS), 'ether')} ETH`);
      console.log(`|----------------------------------------------------------`);
      console.log(` Referer address ${REFERER_ADDRESS}`);
      console.log(` Balance ${web3.utils.fromWei(await web3.eth.getBalance(REFERER_ADDRESS), 'ether')} ETH`);
      console.log(`|----------------------------------------------------------`);

      await deployer.deploy(TestKeysRoles);

      const rolesTestKeys = await TestKeysRoles.deployed();
      const roles = new web3.eth.Contract(rolesTestKeys.abi, rolesTestKeys.address);

      console.log('--------------------------------------------------------------------');
      console.log(`| Admin roles:`);
      console.log('--------------------------------------------------------------------');

      console.log(`Super admin role   [${SUPER_ADMIN_ADDRESS}]: ${await roles.methods.hasRole(SUPER_ADMIN_ROLE, SUPER_ADMIN_ADDRESS).call()}`);
      await roles.methods.addAdmin(SUPER_ADMIN_ROLE, SUPER_ADMIN_ADDRESS).send({
        from: accounts[0]
      });
      console.log(`Super admin role   [${SUPER_ADMIN_ADDRESS}]: ${await roles.methods.hasRole(SUPER_ADMIN_ROLE, SUPER_ADMIN_ADDRESS).call()}`);
      console.log('--------------------------------------------------------------------');

      console.log(`Deployer       [${accounts[0]}]: ${await roles.methods.hasRole(SUPER_ADMIN_ROLE, accounts[0]).call()}`);
      await roles.methods.addAdmin(SUPER_ADMIN_ROLE, accounts[0]).send({
        from: accounts[0]
      });
      console.log(`Deployer       [${accounts[0]}]: ${await roles.methods.hasRole(SUPER_ADMIN_ROLE, accounts[0]).call()}`);

      console.log('--------------------------------------------------------------------');
      console.log(`| Roles:`);
      console.log('--------------------------------------------------------------------');

      console.log(`General partner    [${GENERAL_PARTNER_ADDRESS}]: ${await roles.methods.hasRole(GENERAL_PARTNER_ROLE, GENERAL_PARTNER_ADDRESS).call()}`);
      await roles.methods.grantRole(GENERAL_PARTNER_ROLE, GENERAL_PARTNER_ADDRESS).send({
        from: accounts[0]
      });
      console.log(`General partner    [${GENERAL_PARTNER_ADDRESS}]: ${await roles.methods.hasRole(GENERAL_PARTNER_ROLE, GENERAL_PARTNER_ADDRESS).call()}`);
      console.log('--------------------------------------------------------------------');

      console.log(`Limited partner    [${LIMITED_PARTNER_ADDRESS}]: ${await roles.methods.hasRole(LIMITED_PARTNER_ROLE, LIMITED_PARTNER_ADDRESS).call()}`);
      await roles.methods.grantRole(LIMITED_PARTNER_ROLE, LIMITED_PARTNER_ADDRESS).send({
        from: accounts[0]
      });
      console.log(`Limited partner    [${LIMITED_PARTNER_ADDRESS}]: ${await roles.methods.hasRole(LIMITED_PARTNER_ROLE, LIMITED_PARTNER_ADDRESS).call()}`);
      console.log('--------------------------------------------------------------------');

      console.log(`Team address       [${TEAM_ADDRESS}]: ${await roles.methods.hasRole(TEAM_ROLE, TEAM_ADDRESS).call()}`);
      await roles.methods.grantRole(TEAM_ROLE, TEAM_ADDRESS).send({
        from: accounts[0]
      });
      console.log(`Team address       [${TEAM_ADDRESS}]: ${await roles.methods.hasRole(TEAM_ROLE, TEAM_ADDRESS).call()}`);
      console.log('--------------------------------------------------------------------');

      console.log(`Sturtap team       [${STURTAP_TEAM_ADDRESS}]: ${await roles.methods.hasRole(STURTAP_TEAM_ROLE, STURTAP_TEAM_ADDRESS).call()}`);
      await roles.methods.grantRole(STURTAP_TEAM_ROLE, STURTAP_TEAM_ADDRESS).send({
        from: accounts[0]
      });
      console.log(`Sturtap team       [${STURTAP_TEAM_ADDRESS}]: ${await roles.methods.hasRole(STURTAP_TEAM_ROLE, STURTAP_TEAM_ADDRESS).call()}`);
      console.log('--------------------------------------------------------------------');

      console.log(`Referer            [${REFERER_ADDRESS}]: ${await roles.methods.hasRole(REFERER_ROLE, REFERER_ADDRESS).call()}`);
      await roles.methods.grantRole(REFERER_ROLE, REFERER_ADDRESS).send({
        from: accounts[0]
      });
      console.log(`Referer            [${REFERER_ADDRESS}]: ${await roles.methods.hasRole(REFERER_ROLE, REFERER_ADDRESS).call()}`);

      console.log('--------------------------------------------------------------------');
      console.log('--------------------------------------------------------------------');

      console.log(`Deployer contract isAdmin:   ${await roles.methods.hasRole(SUPER_ADMIN_ROLE, accounts[0]).call()}`);
      await roles.methods.renounceRole(SUPER_ADMIN_ROLE, accounts[0]).send({ from: accounts[0] });
      console.log(`Deployer contract isAdmin:   ${await roles.methods.hasRole(SUPER_ADMIN_ROLE, accounts[0]).call()}`);

      await roles.methods.finalize().send({ from: accounts[0] });

      return;

    } catch (error) {
      console.log("| Deploy error!");
      console.log(error);
    }
  });
};