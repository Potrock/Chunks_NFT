// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "../NFT/IChunk.sol";
import "./IChunk_Building.sol";

contract Building is IChunk_Building, Ownable {
    IChunk private chunk;
    address private buildingManager;
    mapping(uint => uint) public counts;

    constructor(address _buildingManager, address _chunk) {
        buildingManager = _buildingManager;
        chunk = IChunk(_chunk);
    }

    modifier onlyBuildingManager() {
        require(msg.sender == buildingManager);
        _;
    }

    modifier tokenExists(uint _tokenId) {
        require(IChunk(chunk).tokenExists(_tokenId), "Token does not exist!");
        _;
    }

    function setBuildingManager(address _newBuildingManager) public onlyOwner {
        buildingManager = _newBuildingManager;
    }

    function getCountByToken(uint _tokenId) public view returns (uint) {
        return counts[_tokenId];
    }

    function _buildAmount(uint _tokenId, uint _num) internal tokenExists {
        counts[_tokenId] += _num;
    }

    function _destroyAmount(uint _tokenId, uint _num)
        internal
        tokenExists
    {
        require(counts[_tokenId] >= _num, "INSUFFICIENT_BUILDINGS");
        counts[_tokenId] -= _num;
    }
}
