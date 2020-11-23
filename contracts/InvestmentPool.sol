pragma solidity ^0.5.0;



contract InvestmentPool is Pool {
  uint constant DECIMAL_MULTIPLIER = 1e18;
  
  /**  description of params 
   * 
   * 
   * 
   * 
   */
  constructor( address _tokenAddress,
                uint _tokenPrice) public {
    
    //stakeholderShare[_ADMIN] 
    //stakeholderShare[POOL_OPERATOR] 

    setRole_(RL_ADMIN, msg.sender);
    setRole_(RL_POOL_OPERATOR, _poolOperatorAddress);
   
    tokenAddress = _tokenAddress;
    tokenPrice = _tokenPrice;
  }
}