pragma solidity ^0.4.23;

/************
@PriceOracleGetter interface

interface PriceOracleGetter {
    /***********
    @dev returns the asset price in ETH
     */
    function getAssetPrice(address _asset) external view returns (uint256);
}