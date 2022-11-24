// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IChunk_Building {

    function getCountByToken(uint _tokenId) external view returns (uint8);

    function build(uint _tokenId, uint8 _tier) external;
}