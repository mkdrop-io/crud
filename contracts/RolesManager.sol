pragma solidity ^0.4.23;


import "./RoleRegistry.sol";


contract RoleModel is RoleRegistry{

  mapping (address => uint8) internal role_;
  mapping (uint8 => address) internal roleAddress_;
  
  function setRole_(uint8 _for, address _afor) internal returns(bool) {
    require((role_[_afor] == 0) && (roleAddress_[_for] == address(0)));
    role_[_afor] = _for;
    roleAddress_[_for] = _afor;
  }

  function getRole_() view internal returns(uint8) {
    return role_[msg.sender];
  }

  function getRole_(address _for) view internal returns(uint8) {
    return role_[_for];
  }

  function getRoleAddress_(uint8 _for) view internal returns(address) {
    return roleAddress_[_for];
  }
  
  /**
  * returns role of the account address that you sent via param
  * @return role of account (RR_ADMIN, RR_TEAM, RR_LPartner, etc)
  */
  function getRole(address _targetAddress) external view returns(uint8){
    return role_[_targetAddress];
  }

}