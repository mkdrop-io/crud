pragma solidity ^0.4.23;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v1.12.0/contracts/ownership/Ownable.sol";

import "iPool.sol";

/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {

  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a * b;
    assert(a == 0 || c / a == b);
    return c;
  }
 
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }
 
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }
 
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
  
}



library Address { // helper function for address type / openzeppelin-contracts/blob/master/contracts/utils/Address.sol
    function isContract(address account) internal view returns (bool) {
        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts
        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned
        // for accounts without code, i.e. `keccak256('')`
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        // solhint-disable-next-line no-inline-assembly
       // assembly { codehash := extcodehash(account) }
        return (codehash != accountHash && codehash != 0x0);
    }
}

interface IWETH { // brief interface for ether wrapping contract 
    function deposit() payable external;
    function transfer(address dst, uint wad) external returns (bool);
}

interface IERC20 { // brief interface for erc20 token txs
    function balanceOf(address who) external view returns (uint256);
    
    function transfer(address to, uint256 value) external returns (bool);

    function transferFrom(address from, address to, uint256 value) external returns (bool);
}


contract InvestmentPool is IPool {
    
  using SafeMath for uint256; 
//  using SafeERC20 for IERC20;
    
    // The balance in wei the pool currently manages
    uint public poolBalance;
   
    // address where we collect all fees
  address public feesPoolAddress;
  address public projectPoolAddress;  
  
    address private locker = address(this);

    uint256 public lockerIndex;
    mapping(uint256 => Deposit) public deposits; 
  
  // address where we collect all fees

  uint256 public poolCommision;   

  address public poolOwner;   
    
    address public wETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

  mapping (address => uint256) public investments;    

  address[] public addresses;   

  uint256 public balance;   

  uint256 public tokenBalance;
  
  uint256 public collectedAmount;


  modifier onlyOwner() {
    require(msg.sender == poolOwner);
    _;
  }
  
  struct Deposit {  
        address _from; 
        address _tokenAddress;
        uint8 locked;
        uint256 amount;
    }
    
    
    function poolDeposit(address _from,address _tokenAddress, uint256 amount, uint8 period, bool requestDeposit) payable external {


        uint256 index = lockerIndex+1;
        lockerIndex = lockerIndex+1;
        
        deposits[index] = Deposit(_from,_tokenAddress,period,amount);
            
        
        if(!requestDeposit) {
          doDeposit(msg.sender, lockerIndex, _tokenAddress);
            deposits[index]._from = msg.sender;
        }
        
    emit PoolDeposit(msg.sender, _tokenAddress, amount, period); 

                }
        
        
    function doDeposit(address client, uint256 index, address tokenAddress) payable public {
        
        Deposit storage deposit = deposits[index];
        
         if (deposit._tokenAddress == wETH && msg.value > 0) {
            IWETH(wETH).deposit();
            (bool success, ) = wETH.call.value(msg.value)("");
            require(success, "transfer failed");
            IWETH(wETH).transfer(locker, msg.value);
        } else {
            
            IERC20(deposit._tokenAddress).transferFrom(tokenAddress, locker, deposit.amount);
            
            collectedAmount = collectedAmount.add(msg.value);

        // mint new staked tokens
      // LPToken.mint(msg.sender, msg.value);

        }
        
    }
        
    
    function poolWithdrawalRequestCreated(uint256 index) external { 
        
      //Deposit storage deposit = deposits[index];
        
        //require(deposit.locked == 0, "deposit locked");
        //require(deposit.cap > deposit.released, "deposit released");
        //require(now > deposit.termination, "termination time pending");
        
        //uint256 remainder = deposit.cap.sub(deposit.released); 
        
        //IERC20(deposit.token).safeTransfer(deposit.client, remainder);
        
        //deposit.released = deposit.released.add(remainder); 
        
      //emit Withdraw(index, remainder); 
    }
    
      function lock(uint256 index, bytes32 details) external { 
        Deposit storage deposit = deposits[index]; 
        
        //require(deposit.cap > deposit.released, "deposit released");
       // require(now < deposit.termination, "termination time passed"); 
       // require(msg.sender == deposit.client || msg.sender == deposit.provider, "not deposit party"); 
        
      deposit.locked = 1; 
      
      emit Lock(msg.sender, index, details);
    }
    
    
  constructor(uint _minDeposit,
              uint _adminShare, 
              uint _feesPoolAddress,
              address _poolOperatorAddress,
              address _gpartner,
              address _startup,
              address _lpartner,
              address _team,              
              address _referrer             
              ) public {


//    setRole_(RR_ADMIN, msg.sender);
  //  setRole_(RR_GPARTNER, _gpartner);
    //setRole_(RR_STARTUP, _startup);
//    setRole_(RR_TEAM, _team);
  //  setRole_(RR_LPARTNER, _lpartner);
//    setRole_(RR_REFERRER, _referrer);


  //  setRole_(RL_POOL_MANAGER, _poolOperatorAddress);


  }
  
  
  
  function getInvestmentAmount(address _address) public view returns(uint256) {
    require(_address == msg.sender);
    return investments[_address];
  }
  

  function getAddressByNumber(uint256 _number) public view returns(address){
    return addresses[_number];
  }
  
  

  function getPoolCommision() public view returns(uint256) {
    return poolCommision;
  }
  

  
   /**
  * Returns amount of ETH that contributor can withdrow from this contract
  * @param _for role of shareholder (for example: 2)
  * @return amount of ETH in wei
  */
  
  function getStakeholderBalanceOf(uint8 _for) external view returns(uint) {
    return getStakeholderBalanceOf_(_for);
  }

   /**
  * Release ETH to LP Partner
  */
function withdrawEthToLP(uint _value) external returns(bool) {
    //uint8 _state = getState_();
    //uint8 _for = getRole_();
    //require(!(_for == RR_LPARTNER));
    //return releaseStakeToStakeholder_(_state, _for, _value);
  }


 function getCollectedAmount_() internal view returns (uint) {
   return collectedAmount;
  }

  function getStakeholderBalanceOf_(uint8 _for) internal view returns (uint) {
   //...
  }

  function getBalance() public constant returns (uint256) {
    return address(this).balance;
  }
} 