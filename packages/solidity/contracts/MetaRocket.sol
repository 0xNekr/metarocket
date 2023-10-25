// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract MetaRocket is ERC721, AccessControl {

    bytes32 public constant CREATOR_ROLE = keccak256("CREATOR_ROLE");

    enum RocketState { NOT_LAUNCHED, IN_FLIGHT, OUT_OF_GAS, EXPLODED, BLACK_HOLE }

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

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

}

