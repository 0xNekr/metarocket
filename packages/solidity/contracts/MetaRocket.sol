// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MetaRocket is ERC721 {

    enum RocketState { NOT_LAUNCHED, IN_FLIGHT, OUT_OF_GAS, EXPLODED, BLACK_HOLE }

    struct rocket {
        uint256 tokenId;
        string name;
        string description;
        uint64 gasLeft;
        uint64 jumpCount;
        uint64 creationTimestamp;
        uint64 lastJumpTimestamp;
        RocketState state;
        bool gasFree;
        bool indestructible;
    }

    constructor() ERC721("MetaRocket", "MTR") {}

}

