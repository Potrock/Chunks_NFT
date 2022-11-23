// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Roles.sol";
import "./IChunk_Building.sol";
import "../NFT/IChunk.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Farm is IChunk_Building, Roles {
    using Roles for Roles.Role;
    Roles.Role private admins;
    address private CHUNK;
    address private FOOD;
    address private buildingManager;

    constructor(address _food, address _buildingManager) {
        FOOD = _food;
        buildingManager = _buildingManager;
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

    function buildAmount(uint _tokenId, uint _num) public onlyBuildingManager {
        require(chunk.tokenExists(_tokenId), "Token does not exist!");
        counts[_tokenId] += _num;
    }

    function destroyAmount(uint _tokenId, uint _num)
        public
        onlyBuildingManager
    {
        require(chunk.tokenExists(_tokenId), "Token does not exist!");
        require(counts[_tokenId] >= _num, "Not enough Houses on that land");
        counts[_tokenId] -= _num;
    }
}
