pragma solidity ^0.5.0;

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