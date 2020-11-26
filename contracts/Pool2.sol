pragma solidity ^0.4.16;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "@openzeppelin/contracts/utils/EnumerableSet.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


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


contract AbstractProject {
  
  function balanceOf(address _who) public view returns (uint256);

  function transfer(address _to, uint256 _value) public returns (bool);

  function transferFrom(address _from, address _to, uint256 _value)
    public returns (bool);
}

contract InvestPool {
    
  using SafeMath for uint256; 
    
    // The balance in wei the pool currently manages
    uint public poolBalance;
   
    // address where we collect all fees
  address public feesPoolAddress;
  address public projectPoolAddress;  
  
  //The min/max a contributor has to send to participate in the pool
  uint256 public maxContribution;   
  uint256 public minContribution; 
  
  // address where we collect all fees

  uint256 public poolCommision;   

  address public poolOwner;   
  uint256 public start;   
  uint256 public period;    
  uint256 public criticalDate;    

  bool public isInvest = false;   

  mapping (address => uint256) public investments;    

  address[] public addresses;   

  uint256 public balance;   

  uint256 public tokenBalance;

   // Info of each pool.
    struct PoolInfo {
        address poolAddress; // Address of pool contract.
        uint256 allocTokens; // How many tokens allocated in this pool
        uint256 allocFunds; // How many funds allocated in this pool
        uint256 OCCPerShare; // Accumulated OCC per share
    }


  //States of Pool:
  //PoolOpen: Accepting
  //PayOut: Withdraw
  enum States {
    PoolActive,  //0
    PoolClosed    //1
  }

  modifier onlyOwner() {
    require(msg.sender == poolOwner);
    _;
  }
  
  constructor (address _projectPoolAddress,
            uint256 _maxContribution, 
            uint256 _minContribution,
            uint256 _poolCommision,
            address _poolOwner
            ) public {
    
      feesPoolAddress = msg.sender;
    projectAddress = _projectPoolAddress;
    maxTotalAmount = __maxContribution;
    minTotalAmount = _minContribution;
  
    poolCommision = _poolCommision;
    
    poolOwner = _poolOwner;
//    start = _start;
//    period = _period;
    criticalDate = _criticalDate;
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
  
  
  function investProject() public onlyOwner payable returns(bool) {
      
    icoWorldAddress.transfer(address(this).balance.mul(icoWorldCommision).div(100));
    projectAddress.call.value(address(this).balance)();
    AbstractProject ProjectContract = AbstractProject(projectAddress);
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
    uint8 _state = getState_();
    uint8 _for = getRole_();
    require(!(_for == RR_LPARTNER));
    return releaseStakeToStakeholder_(_state, _for, _value);
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







pragma solidity ^0.4.17;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "@openzeppelin/contracts/utils/EnumerableSet.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./OCCToken.sol";

contract Pool {
  
  uint pool = 0;


  event Deposit(
        address indexed _reserve,
        address indexed _user,
        uint256 _amount,
        uint256 _timestamp,
        uint256 sharesCreated
    );

  event Withdraw(
        address indexed _reserve,
        address indexed _user,
        uint256 _amount,
        uint256 _timestamp,
        uint256 sharesRemoved
    );

    struct UserInfo {
        uint256 amount; // How many investments the user has provided.
        uint256 bonusToken; // Reward for investment (token)?
   
        //
        // no metter a user deposits or withdraws shares from a pool:
        //   1. The pool share will be updated.
        //   2. User's `amount` gets updated.
    }

    // Info of each pool.
    struct PoolInfo {
        address poolAddress; // Address of pool contract.
        uint256 allocTokens; // How many tokens allocated in this pool
        uint256 allocFunds; // How many funds allocated in this pool
        uint256 OCCPerShare; // Accumulated OCC per share
    }


  //States of Pool:
  //PoolOpen: Accepting
  //PayOut: Withdraw
  enum States {
    PoolActive,  //0
    PoolClosed    //1
  }

  States state = States.PoolActive;

 //View Status of contract State
  function stateOfPool() public view returns(States){
      return state;
  }

  //View Size of pool
  function poolSize() public view returns (uint){
      return pool;
  }



  constructor( address _tokenAddress,
                uint _tokenPrice) public {
    
    //stakeholderShare[_ADMIN] 
    //stakeholderShare[POOL_OPERATOR] 

    setRole_(RR_ADMIN, msg.sender);
    setRole_(RR_POOL_OPERATOR, _poolOperatorAddress);
   
    tokenAddress = _tokenAddress;
    tokenPrice = _tokenPrice;
    }
  }