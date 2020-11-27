pragma solidity ^0.5.0;

contract RolesRegistry {

  /**
  * RR_ADMIN - The Role controls adding a new wallet addresses to according roles arrays
  */

  address RR_ADMIN = 0x97E8df9745f22E00691F0cBd880e0e7e612a5d0a;

  /**
  * RR_GPartner - The Role controls the approval process to transfer money inside
  *               investment pools and control Limited Partners adding, investment
  *               pools adding
  */

  address RR_GPartner = 0x5568C2CEe13045bC0843CB76E1213F496EFeDEaa;

  /**
  * RR_LPARTNER - The Role allows the wallet of LP to invest money in the
  *               investment pool and withdraw money from there (access to limited pools)
  */
  address RR_LPartner = 0x1C456598a1828693EC4B92D2871A308A6553F819;

  /**
  * RR_TEAM - Role that exposes access to wallets (the team member), were
  *           distributed all fees, fines, and success premiums from investment pools
  */

  /**
  * RR_STARTUP - Role that exposes access to wallets which can withdraw
  *              investor’s money after convert to tokens/NFT assets (access tolimited pools)
  */

  address RR_STARTUP = 0xC71DfA76Ea5eCAe6F03162Ba0902Af3a3392bE2c;


  /**
  * RR_REFERRER - Registry of wallets, which connects LP with their Referrer to sent
  *               there a part of the fees.
  */

  address RR_REFERRER = 0x52a405C479bAC25B536B0eC89229Ee9e34AF4d82;

  
  function getRole_() view internal returns(uint8);
  function getRole_(address _for) view internal returns(uint8);
  function getRoleAddress_(uint8 _for) view internal returns(address);
  
  }