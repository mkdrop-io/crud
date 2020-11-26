pragma solidity ^0.5.0;

contract RolesRegistry {

  /**
  * RR_ADMIN - The Role controls adding a new wallet addresses to according roles arrays
  */

  uint8 constant RR_ADMIN = 0x;

  /**
  * RR_GPartner - The Role controls the approval process to transfer money inside
  *               investment pools and control Limited Partners adding, investment
  *               pools adding
  */

  uint8 constant RR_GPartner = 0x;

  /**
  * RR_LPARTNER - The Role allows the wallet of LP to invest money in the
  *               investment pool and withdraw money from there (access to limited pools)
  */
  uint8 constant RR_LPartner = 0x;

  /**
  * RR_TEAM - Role that exposes access to wallets (the team member), were
  *           distributed all fees, fines, and success premiums from investment pools
  */

  /**
  * RR_STARTUP - Role that exposes access to wallets which can withdraw
  *              investor’s money after convert to tokens/NFT assets (access tolimited pools)
  */

  uint8 constant RR_STARTUP = 0x;


  /**
  * RR_REFERRER - Registry of wallets, which connects LP with their Referrer to sent
  *               there a part of the fees.
  */

  uint8 constant RR_REFERRER = 0x;

  
  function getRole_() view internal returns(uint8);
  function getRole_(address _for) view internal returns(uint8);
  function getRoleAddress_(uint8 _for) view internal returns(address);
  
  }