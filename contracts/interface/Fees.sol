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
    function setPoolAPY(uint256 indexed pid, uint256 rate) external view returns (uint256);
    function getPoolAPY(uint256 indexed pid) external view returns (uint256);
}