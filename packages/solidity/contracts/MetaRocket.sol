// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract MetaRocket is ERC721, AccessControl {

    bytes32 public constant CREATOR_ROLE = keccak256("CREATOR_ROLE");

    uint256 private _currentTokenId = 0;

    enum RocketState { NOT_LAUNCHED, IN_FLIGHT, OUT_OF_GAS, EXPLODED, BLACK_HOLE }

    mapping(uint256 => rocket) public rockets;

    struct rocket {
        uint256 tokenId;
        string name;
        string description;
        uint64 gasLeft;
        uint64 gasCapacity;
        uint64 jumpCount;
        uint64 creationTimestamp;
        uint64 lastJumpTimestamp;
        RocketState state;
        bool gasFree;
        bool indestructible;
    }

    constructor() ERC721("MetaRocket", "MTR") {
        _grantRole(DEFAULT_ADMIN_ROLE, _msgSender());
        _grantRole(CREATOR_ROLE, _msgSender());
    }

    function createRocket(
        address to,
        string calldata name,
        string calldata description,
        uint64 gasLeft,
        uint64 gasCapacity,
        bool gasFree,
        bool indestructible
    ) external onlyRole(CREATOR_ROLE) {
        uint256 tokenId = _currentTokenId;
        _safeMint(to, tokenId);
        _rocketInitialization(tokenId, name, description, gasLeft, gasCapacity, gasFree, indestructible);
        _currentTokenId++;
    }

    function _rocketInitialization(
        uint256 _rocketId,
        string calldata _name,
        string calldata _description,
        uint64 _gasLeft,
        uint64 _gasCapacity,
        bool _gasFree,
        bool _indestructible
    ) internal {
        rockets[_rocketId] = rocket(
            _rocketId,
            _name,
            _description,
            _gasLeft,
            _gasCapacity,
            0,
            uint64(block.timestamp),
            uint64(block.timestamp),
            RocketState.NOT_LAUNCHED,
            _gasFree,
            _indestructible
        );
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

}
