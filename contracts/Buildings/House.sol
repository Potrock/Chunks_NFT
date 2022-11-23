// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./IChunk_Building.sol";
import "../NFT/IChunk.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract House is IChunk_Building, Ownable {
    address public buildingManager;
    IChunk public chunk;
    mapping(uint => uint) counts;

    constructor(address _buildingManager, address _chunk) {
        buildingManager = _buildingManager;
        chunk = IChunk(_chunk);
    }

    modifier onlyBuildingManager() {
        require(msg.sender == buildingManager);
        _;
    }

    function setBuildingManager(address _newBuildingManager) public onlyOwner {
        buildingManager = _newBuildingManager;
    }

    function getCountByToken(uint _tokenId) public view returns (uint) {
        require(chunk.tokenExists(_tokenId), "Token does not exist!");
        return counts[_tokenId];
    }

    function buildAmount(uint _tokenId, uint _num) onlyBuildingManager public {
        require(chunk.tokenExists(_tokenId), "Token does not exist!");
        counts[_tokenId] += _num;
    }

    function destroyAmount(uint _tokenId, uint _num) onlyBuildingManager public {
        require(chunk.tokenExists(_tokenId), "Token does not exist!");
        require(counts[_tokenId] >= _num, "Not enough Houses on that land");
        counts[_tokenId] -= _num;
    }
}
