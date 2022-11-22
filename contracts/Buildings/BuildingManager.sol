// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "../NFT/IChunk.sol";
import "./IChunk_Building.sol";

contract BuildingManager is Ownable {

    IChunk public chunk;
    mapping(uint => IChunk_Building) public buildingContracts;
    uint public numBuildings;

    constructor(address _chunk) {
        chunk = IChunk(_chunk);
    }

    modifier buildingExists(buildingId) {
        require(buildingContracts[buildingId] != address(0), "Building does not exist");
        _;
    }

    modifier tokenExists(tokenId) {
        require(chunk.tokenExists(tokenId), "Token does not exist");
    }

    function registerBuilding(IChunkBuilding address) public onlyOwner {
        buildingContracts[numBuildings] = address;
        numBuildings++;
    }

    function addBuildingTo(buildingId, tokenId, amount) public onlyOwner buildingExists tokenExists {
        
    }
}