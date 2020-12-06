pragma solidity ^0.6.0;

interface IPool {
    // Deposits

    event PoolDeposit(
        address indexed _from,
        address indexed _tokenAddress,
        uint256 _amount,
        uint256 lock_period
    );

    event DepositRequest(
        address indexed _lpAddress,
        address indexed _tokenAddress,
        bytes32 indexed _id,
        uint256 _maxValue
    );

    event PoolFundingRequestApproved(
        address indexed _lpAddress,
        address indexed _tokenAddress,
        bytes32 indexed _id,
        uint256 value
    );

    event PoolFundingRequestDenied(
        address indexed _lpAddress,
        address indexed _tokenAddress,
        bytes32 indexed _id,
        uint256 _maxValue
    );

    // Withdrawals

    event PoolWithdrawalRequestCreated(
        address indexed _from,
        bytes32 indexed _id,
        address indexed tokenAddress,
        uint256 _amount
    );

    event PoolWithdrawalRequestApproved(
        address indexed _from,
        bytes32 indexed _id,
        address indexed tokenAddress,
        uint256 _value
    );

    event PoolWithdrawalRequestDenied(
        address indexed _from,
        bytes32 indexed _id,
        address indexed tokenAddress,
        uint256 _value
    );

    event WithdrawalRequestCompleted(
        address indexed _from,
        bytes32 indexed _id,
        address indexed tokenAddress,
        uint256 _value
    );

    event Lock(
        address indexed sender,
        uint256 indexed index,
        bytes32 indexed details
    );

    /**
     * @dev triggered every time when Contributer get ETH from contract
     * @param role is a role of stakeholder (for example: RR_LPARTNER)
     */

    event ReleaseEthToContributer(
        uint8 indexed role,
        address indexed addr,
        uint256 value
    );

    event ReleaseEther(address indexed addr, uint256 value);

    event ReleaseToken(address indexed addr, uint256 value);
    
    // ***** GET INFO ***** //

    function hasRole(bytes32 role, address account) external view returns (bool);

    function getRoleMemberCount(bytes32 role) external view returns (uint256);

    function token() external view returns (address);

    function locked() external view returns (uint256);

    function rate() external view returns (uint256);

    function interestFee() external view returns (uint256);

    function anualPrecent() external view returns (uint256);

    // ***** SET NEW VALUE ***** //

    function setLock(uint256 lock) external returns (bool);

    function setRate(uint256 rate) external returns (bool);

    function setInterestFee(uint256 fee) external returns (bool);

    function setAnnualPrecent(uint256 precent) external returns (bool);
}
