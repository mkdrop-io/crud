pragma solidity ^0.6.0;

import "./IPool.sol";

import "./Roles.sol";
import "./InvestmentPool.sol";

import "./EnumerableSet.sol";

contract PoolRegistry is Roles {
    using EnumerableSet for EnumerableSet.AddressSet;

    // Pool information
    struct Pool {
        address token;
        uint256 locked;
        uint256 rate;
        uint256 interestFee;
        uint256 anualPrecent;
    }

    // Collection of all pools
    mapping(address => Pool) private _pools;
    // Collection of all pool addresses
    EnumerableSet.AddressSet private _addressesPools;

    event CreatePool(address pool, address token, uint256 lock, uint256 rate, uint256 interestFee, uint256 anualPrecent);
    event AddPool(address pool, address token, uint256 lock, uint256 rate, uint256 interestFee, uint256 anualPrecent);
    event UpdatePool(address pool, uint256 lock, uint256 rate, uint256 interestFee, uint256 anualPrecent);

    /**
    * @dev Create new investment pool.
    * @param token The address token contract for investment pool.
    * @param locked The blocking period of assets.
    * @param rate The address to query the wager of.
    * @param interestFee The asset withdrawal commission.
    * @param anualPrecent The annual percentage of tokens.
    * @param superAdmin The An address that has privileges SUPER_ADMIN_ROLE.
    * @param gPartner The An address that has privileges GENERAL_PARTNER_ROLE.
    * @param lPartner The An address that has privileges LIMITED_PARTNER_ROLE.
    * @param team The An address that has privileges TEAM_ROLE.
    * @param sturtapTeam The An address that has privileges STURTAP_TEAM_ROLE.
    * @param referer The An address that has privileges REFERER_ROLE.
    * @return A boolean that indicates if the operation was successful.
    */
    function createPool(
        address token,
        uint256 locked,
        uint256 rate,
        uint256 interestFee,
        uint256 anualPrecent,
        address superAdmin,
        address gPartner,
        address lPartner,
        address team,
        address sturtapTeam,
        address referer
    ) public onlyGPartner returns (bool) {
        InvestmentPool _poolContract = new InvestmentPool(
            token,
            locked,
            rate,
            interestFee,
            anualPrecent,
            superAdmin,
            gPartner,
            lPartner,
            team,
            sturtapTeam,
            referer,
            _msgSender()
        );
        address poolAddress = address(_poolContract);

        _pools[poolAddress] = Pool(
            token,
            locked,
            rate,
            interestFee,
            anualPrecent
        );

        _addressesPools.add(poolAddress);

        emit CreatePool(poolAddress, token, locked, rate, interestFee, anualPrecent);
        return true;
    }
    
    /**
    * @dev Add new smart contract investment pool.
    * @param poolAddress The address investment pool.
    * @return A boolean that indicates if the operation was successful.
    */
    function addPool(address poolAddress) public virtual returns (bool) {
        require(poolAddress != address(0), "PoolRegistry: pool zero address");
        require(!_addressesPools.contains(poolAddress), "PoolRegistry: pool with this address already exists");

        IPool poolContract = IPool(poolAddress);

        require(poolContract.hasRole(GENERAL_PARTNER_ROLE, msg.sender), "PoolRegistry: the sender does not have permission to update");

        address _token = poolContract.token();
        require(_token != address(0), "PoolRegistry: token zero address");

        uint256 _locked = poolContract.locked();
        uint256 _rate = poolContract.rate();
        uint256 _interestFee = poolContract.interestFee();
        uint256 _anualPrecent = poolContract.anualPrecent();
        
        _pools[poolAddress] = Pool(
                _token,
                poolContract.locked(),
                poolContract.rate(),
                poolContract.interestFee(),
                poolContract.anualPrecent()
            );

        _addressesPools.add(poolAddress);

        emit AddPool(poolAddress, _token, _locked, _rate, _interestFee, _anualPrecent);
        return true;
    }

    /**
    * @dev Update smart contract investment pool.
    * @param pool The address investment pool.
    * @param lock The blocking period of assets.
    * @param rate The address to query the wager of.
    * @param interestFee The asset withdrawal commission.
    * @param anualPrecent The annual percentage of tokens.
    * @return A boolean that indicates if the operation was successful.
    */
    function updatePool(address pool, uint256 lock, uint256 rate, uint256 interestFee, uint256 anualPrecent) public virtual returns (bool) {
        require(pool != address(0), "PoolRegistry: pool zero address");
        require(_addressesPools.contains(pool), "PoolRegistry: pool with this address not exists");

        IPool poolContract = IPool(pool);
        
        require(poolContract.hasRole(GENERAL_PARTNER_ROLE, msg.sender), "PoolRegistry: the sender does not have permission to update");
        
        poolContract.setLock(lock);
        poolContract.setRate(rate);
        poolContract.setInterestFee(interestFee);
        poolContract.setAnnualPrecent(anualPrecent);
        
        _pools[pool].locked = lock;
        _pools[pool].rate = rate;
        _pools[pool].interestFee = interestFee;
        _pools[pool].anualPrecent = anualPrecent;
        
        emit UpdatePool(pool, lock, rate, interestFee, anualPrecent);
        return true;
    }

    /**
    * @param pool The address investment pool.
    */
    function getPollInfo(address pool) public view returns(address token, uint256 lock, uint256 rate, uint256 interestFee, uint256 anualPrecent) {
        require(pool != address(0), "PoolRegistry: pool zero address");
        require(_addressesPools.contains(pool), "PoolRegistry: pool with this address not exists");
        
        return (
            _pools[pool].token,
            _pools[pool].locked,
            _pools[pool].rate,
            _pools[pool].interestFee,
            _pools[pool].anualPrecent
            );
    }
    
    /**
    * @return the all investment pool addresses.
    */
    function getPools() public view returns (address[] memory) {
        return _addressesPools.collection();
    }
}