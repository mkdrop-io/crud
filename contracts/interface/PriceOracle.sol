pragma solidity ^0.4.23;

/************
@title PriceOracle interface
@notice Interface for the Crud price oracle.*/
interface IPriceOracle {
    /***********
    @dev returns the asset price in ETH
     */
    function getAssetPrice(address _asset) external view returns (uint256);

    /***********
    sets the asset price, in wei
     */
    function setAssetPrice(address _asset, uint256 _price) external;
}