pragma solidity ^0.4.25;

import "./access/Roles.sol";
import "./math/SafeMath.sol";

contract TestKeysRoles is Roles {
    using SafeMath for uint256;

    uint256 private _checkSuperAdminRole = 0;
    uint256 private _checkGeneralPartnerRole = 0;
    uint256 private _checkLimitedPartnerRole = 0;
    uint256 private _checkTeamRole = 0;
    uint256 private _checkStartupTeamRole = 0;
    uint256 private _checkRefererRole = 0;
    uint256 private _miltipleRole = 0;

    function changeSuperAdmin() public onlyAdmin returns (bool) {
        _checkSuperAdminRole = _checkSuperAdminRole.add(1);
        return true;
    }

    function changeGPartner() public onlyGPartner returns (bool) {
        _checkGeneralPartnerRole = _checkGeneralPartnerRole.add(1);
        return true;
    }

    function changeLPartner() public onlyLPartner returns (bool) {
        _checkLimitedPartnerRole = _checkLimitedPartnerRole.add(1);
        return true;
    }

    function changeTeam() public onlyTeam returns (bool) {
        _checkTeamRole = _checkTeamRole.add(1);
        return true;
    }

    function changeSturtapTeam() public onlySturtapTeam returns (bool) {
        _checkStartupTeamRole = _checkStartupTeamRole.add(1);
        return true;
    }

    function changeRefererRole() public onlyReferer returns (bool) {
        _checkRefererRole = _checkRefererRole.add(1);
        return true;
    }

    function changeMultipleRole() public onlyAdmin onlyGPartner returns (bool) {
        _miltipleRole = _miltipleRole.add(1);
        return true;
    }

    /////////////////// GET VALUE CHANGES VARIABLES ////////////////////
    function getSuperAdminValue() public view returns (uint256) {
        return _checkSuperAdminRole;
    }

    function getGPartnerValue() public view returns (uint256) {
        return _checkGeneralPartnerRole;
    }

    function getLPartnerValue() public view returns (uint256) {
        return _checkLimitedPartnerRole;
    }

    function getTeamValue() public view returns (uint256) {
        return _checkTeamRole;
    }

    function getStartapTeamValue() public view returns (uint256) {
        return _checkStartupTeamRole;
    }

    function getRefererValue() public view returns (uint256) {
        return _checkRefererRole;
    }

    function getMultipleRole() public view returns (uint256) {
        return _miltipleRole;
    }
}
