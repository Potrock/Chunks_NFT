// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "../Buildings/IChunk_Building.sol";
import "../NFT/IChunk.sol";
import "./Unit.sol";

contract Food is Unit {
    mapping(uint256 => uint256) public claimTimes;

    constructor(address _chunkContract, address _farm)
        Unit(_chunkContract, _farm)
    {}
}
