pragma solidity ^0.4.23;


contract IPool is Pool {
  

    // Deposits

    event PoolDeposit(address indexed _from, address indexed _tokenAddress, uint256 _value);
    
    event DepositRequest(address indexed _lpAddress, address indexed _tokenAddress, bytes32 indexed _id, uint256 _maxValue);

    event PoolFundingRequestApproved(address indexed _lpAddress, address indexed _tokenAddress, bytes32 indexed _id, uint256 value);
   
    event PoolFundingRequestDenied(address indexed _lpAddress, address indexed _tokenAddress, bytes32 indexed _id, uint256 _maxValue);

    // Withdrawals

    event PoolWithdrawalRequestCreated(address indexed _from, bytes32 indexed _id, address indexed tokenAddress,uint256 _value);

    event PoolWithdrawalRequestApproved(address indexed _from, bytes32 indexed _id, address indexed tokenAddress,uint256 _value);
    
    event PoolWithdrawalRequestDenied(address indexed _from, bytes32 indexed _id, address indexed tokenAddress,uint256 _value);
    
    event WithdrawalRequestCompleted(address indexed _from, bytes32 indexed _id, address indexed tokenAddress, uint256 _value);


  /**
  * @dev triggered every time when Contributer get ETH from contract
  * @param role is a role of stakeholder (for example: RR_LPARTNER)
  */

  event ReleaseEthToContributer(uint8 indexed role, address indexed addr, uint value);

  event ReleaseEther(address indexed addr, uint value);
  
  event ReleaseToken(address indexed addr, uint value);


}