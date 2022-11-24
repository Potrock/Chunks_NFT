// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./IChunk_Building.sol";
import "../NFT/IChunk.sol";

contract BuildingManager is Ownable {

    IChunk public chunk;
    mapping(uint => address) public buildingContracts;
    uint public numBuildings;

    constructor(address _chunk) {
        chunk = IChunk(_chunk);
    }

    modifier buildingExists(uint _buildingId) {
        require(buildingContracts[_buildingId] != address(0), "Building does not exist");
        _;
    }

    modifier tokenExists(uint _tokenId) {
        require(chunk.tokenExists(_tokenId), "Token does not exist");
        _;
    }

    function registerBuilding(address _address) public onlyOwner {
        buildingContracts[numBuildings] = _address;
        numBuildings++;
    }

    function addBuildingTo(uint _buildingId, uint _tokenId, uint8 _tier) public onlyOwner buildingExists(_buildingId) tokenExists(_tokenId) {
        IChunk_Building(buildingContracts[_buildingId]).build(_tokenId, _tier);
    }

    function getBuildingCountById(uint _buildingId, uint _tokenId) public view buildingExists(_buildingId) tokenExists(_tokenId) returns (uint) {
        return IChunk_Building(buildingContracts[_buildingId]).getCountByToken(_tokenId);
    }
}