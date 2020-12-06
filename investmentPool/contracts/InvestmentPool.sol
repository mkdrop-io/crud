pragma solidity ^0.6.0;

import "./interface/IPool.sol";
import "./interface/IERC20.sol";

import "./access/Roles.sol";

import "./math/SafeMath.sol";
import "./utils/EnumerableSet.sol";

contract InvestmentPool is Roles {
    // Address token contract ERC20
    address private _token;
    // Accessing contract methods
    // IERC20 _tokenContract = IERC20(_token);

    uint256 private _locked;
    uint256 private _rate;
    uint256 private _interestFee;
    uint256 private _anualPrecent;

    constructor(
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
    ) public {
        _token = token;
        _locked = locked;
        _rate = rate;
        _interestFee = interestFee;
        _anualPrecent = anualPrecent;

        Roles.addAdmin(SUPER_ADMIN_ROLE, msg.sender);
        Roles.addAdmin(SUPER_ADMIN_ROLE, superAdmin);
        Roles.finalize();
        grantRole(GENERAL_PARTNER_ROLE, gPartner);
        grantRole(LIMITED_PARTNER_ROLE, lPartner);
        grantRole(TEAM_ROLE, team);
        grantRole(STURTAP_TEAM_ROLE, sturtapTeam);
        grantRole(REFERER_ROLE, referer);
    }

    function token() public view returns (address) {
        return _token;
    }

    function locked() public view returns (uint256) {
        return _locked;
    }

    function rate() public view returns (uint256) {
        return _rate;
    }

    function interestFee() public view returns (uint256) {
        return _interestFee;
    }

    function anualPrecent() public view returns (uint256) {
        return _anualPrecent;
    }

    function setLock(uint256 lock) public virtual onlyGPartner returns (bool) {
        _locked = lock;
        return true;
    }

    function setRate(uint256 rate) public virtual onlyGPartner returns (bool) {
        _rate = rate;
        return true;
    }

    function setInterestFee(uint256 fee) public virtual onlyGPartner returns (bool){
        _interestFee = fee;
        return true;
    }

    function setAnnualPrecent(uint256 precent) public virtual onlyGPartner returns (bool){
        _anualPrecent = precent;
        return true;
    }
}
