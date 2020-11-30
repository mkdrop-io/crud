pragma solidity ^0.4.23;


interface PriceOracleGetter {
    /***********
    returns the asset price in ETH
     */
    function getAssetPrice(address _asset) external view returns (uint256);
}