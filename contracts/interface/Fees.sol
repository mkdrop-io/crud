pragma solidity ^0.4.23;

/************
@title crudFee interface
@notice Interface for the Fees.
*/

interface crudFee {
    function calculateDebtFee(address _user, uint256 _amount) external view returns (uint256);
    function getFeePercentage() external view returns (uint256);
    function setRoleFeePercentage() external view returns (uint256);
    function getRoleFeePercentage() external view returns (uint256);
    function setPoolAPY() external view returns (uint256);
    function getPoolAPY() external view returns (uint256);
}