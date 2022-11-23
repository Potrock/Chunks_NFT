// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IChunk {
    function tokenExists(uint _tokenId) external view returns (bool);
}