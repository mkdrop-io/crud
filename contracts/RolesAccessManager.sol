pragma solidity ^0.5.0;


/**
* @title Roles control
* @notice Implements runtime configurable Role Access Control.
*/
contract RolesAccessControl {
   
   event RoleCreated(uint256 role);
   event PermissionAdded(address account, uint256 role);
   event PermissionRemoved(address account, uint256 role);

  
   struct Role {
       string description;
       uint256 admin;
       address[] paccounts;
   }

   /**
    * @notice All roles ever created.
    */
   Role[] public roles;

   /**
    * @notice The contract constructor, empty as of now.
    */
   constructor() public {
   }

 
   function addRole(string memory _roleDescription, uint256 _admin)
       public
       returns(uint256)
   {
       require(_admin <= roles.length, "Admin role doesn't exist.");
       uint256 role = roles.push(
           Role({
               description: _roleDescription,
               admin: _admin,
               paccounts: new address[](0)
           })
       ) - 1;
       emit RoleCreated(role);
       if (_admin == role) {
           roles[role].paccounts.push(msg.sender);
           emit PermissionAdded(msg.sender, role);
       }
       return role;
   }

  
   function hasRole(address _account, uint256 _role)
       public
       view
       returns(bool)
   {
       if (_role >= roles.length ) return false;
       address[] memory _paccounts = roles[_role].paccounts;
       for (uint256 i = 0; i < _paccounts.length; i++){
           if (_paccounts[i] == _account) return true;
       }
       return false;
   }

 
   function addPermission(address _account, uint256 _role)
       public
   {
       require(_role < roles.length, "Role doesn't exist.");
       require(
           hasRole(msg.sender, roles[_role].admin),
           "User not authorized to add another accounts."
       );
       if (hasRole(_account, _role) == false){
           roles[_role].paccounts.push(_account);
           emit PermissionAdded(_account, _role);
       }
   }

  
   function removePermission(address _account, uint256 _role)
       public
   {
       require(_role < roles.length, "Role doesn't exist.");
       require(
           hasRole(msg.sender, roles[_role].admin),
           "User not authorized to remove accounts."
       );
       address[] memory _paccounts = roles[_role].paccounts;
       for (uint256 i = 0; i < _paccounts.length; i++){
           if (_paccounts[i] == _account){
               _paccounts[i] = _paccounts[_paccounts.length - 1];
               roles[_role].paccounts.pop();
               emit PermissionRemoved(_account, _role);
           }
       }
   }
}