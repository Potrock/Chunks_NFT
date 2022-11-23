// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IChunk_Building {

    function getCountByToken(uint _tokenId) external view returns (uint);

    function buildAmount(uint _tokenId, uint _num) external;

    function destroyAmount(uint _tokenId, uint _num) external;

    function setBuildingManager(address _newBuildingManager) external;
}