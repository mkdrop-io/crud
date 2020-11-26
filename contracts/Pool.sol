pragma solidity ^0.4.16;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v1.12.0/contracts/ownership/Ownable.sol";

import "./IPool.sol";

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



contract InvestmentPool is IPool {
    
  using SafeMath for uint256; 
    
    // The balance in wei the pool currently manages
    uint public poolBalance;
   
    // address where we collect all fees
  address public feesPoolAddress;
  address public projectPoolAddress;  
  
    address private locker = address(this);
    //address public wETH = 
    uint256 public lockerIndex;
    mapping(uint256 => Deposit) public deposits; 
  
  // address where we collect all fees

  uint256 public poolCommision;   

  address public poolOwner;   
    


  mapping (address => uint256) public investments;    

  address[] public addresses;   

  uint256 public balance;   

  uint256 public tokenBalance;

  modifier onlyOwner() {
    require(msg.sender == poolOwner);
    _;
  }
  
  struct Deposit {  
        address _from; 
        address _tokenAddressr;
        uint8 locked;
        uint256 amount;
    }
    
    
    function PoolDeposit(  
        address _from,
        address _tokenAddress,
        uint256 amount, 
        uint256 period,
        bool requestDeposit) payable external {

      address _from = address(0);

        uint256 index = lockerIndex+1;
        lockerIndex = lockerIndex+1;
        
        deposits[index] = Deposit(_from,_tokenAddress,amount,period);
            
        
        if(!requestDeposit) {
          doDeposit(_msgSender(), lockerIndex);
            deposits[index].client = _msgSender();
        }
        
        
        emit DepositToken(_msgSender(), lockerIndex); 
    }
    
    function depositToken() {}...
    
    function PoolWithdrawalRequestCreated(uint256 index) external { 
        
      Deposit storage deposit = deposits[index];
        
        require(deposit.locked == 0, "deposit locked");
        require(deposit.cap > deposit.released, "deposit released");
        require(now > deposit.termination, "termination time pending");
        
        
        IERC20(deposit.token).safeTransfer(deposit.client, remainder);
        
        deposit.released = deposit.released.add(remainder); 
        
      emit Withdraw(index, remainder); 
    }
    
      function lock(uint256 index, bytes32 details) external { 
        Deposit storage deposit = deposits[index]; 
        
        require(deposit.cap > deposit.released, "deposit released");
        require(now < deposit.termination, "termination time passed"); 
        require(_msgSender() == deposit.client || _msgSender() == deposit.provider, "not deposit party"); 
        
      deposit.locked = 1; 
      
      emit Lock(_msgSender(), index, details);
    }
    
    
  constructor(uint _minDeposit,
              uint _adminShare, 
              uint _feesPoolAddress,
              address _poolOperatorAddress,
              address _gpartner,
              address _startup,
              address _lpartner,
              address _team,              
              address _referrer,              
              ) public {


    setRole_(RR_ADMIN, msg.sender);
    setRole_(RR_GPARTNER, _gpartner);
    setRole_(RR_STARTUP, _startup);
    setRole_(RR_TEAM, _team);
    setRole_(RR_LPARTNER, _lpartner);
    setRole_(RR_REFERRER, _referrer);


    setRole_(RL_POOL_MANAGER, _poolOperatorAddress);


  }
  

  function() external payable {
      //require(now > start && now < start + period*24*60*60 && (balance + msg.value) <= maxTotalAmount && msg.value >= minTotalAmountForOne && msg.value <= maxTotalAmountForOne);
      investments[msg.sender] = investments[msg.sender].add(msg.value);
      addresses.push(msg.sender);
      balance = balance.add(msg.value);
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
  
  function getIsInvest() public view returns(bool) {
    return isInvest;
  }
  
  
  function investProject() public payable returns(bool) {
      feesPoolAddress.transfer(address(this).balance.mul(poolCommision).div(100));
    projectPoolAddress.call.value(address(this).balance)();
    AbstractProject ProjectContract = AbstractProject(projectPoolAddress);
    tokenBalance = ProjectContract.balanceOf(address(this));
    isInvest = true;
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

  function refund() public returns(bool) {
    require(now > criticalDate && !(isInvest));
    uint256 value = investments[msg.sender];
    investments[msg.sender] = 0;
    msg.sender.transfer(value);
  }


  function getStakeholderBalanceOf_(uint8 _for) internal view returns (uint) {
   //...
  }

  function getBalance() public constant returns (uint256) {
    return address(this).balance;
  }
} 