// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "../NFT/IChunk.sol";
import "./IChunk_Building.sol";

contract Building is IChunk_Building, Ownable {

    struct BuildingInfo {
        uint interactTimestamp;
        uint8 tier;
    }

    IChunk private chunk;
    address private buildingManager;
    mapping(uint => uint8) public counts;
    mapping(uint => mapping(uint8 => BuildingInfo)) public infos;

    constructor(address _buildingManager, address _chunk) {
        buildingManager = _buildingManager;
        chunk = IChunk(_chunk);
    }

    modifier onlyBuildingManager() {
        require(msg.sender == buildingManager);
        _;
    }

    modifier tokenExists(uint _tokenId) {
        require(chunk.tokenExists(_tokenId), "Token does not exist!");
        _;
    }

    modifier onlyTokenOwner(uint _tokenId) {
        require(msg.sender == address(chunk));
        _;
    }

    function setBuildingManager(address _newBuildingManager) public onlyOwner {
        buildingManager = _newBuildingManager;
    }

    function setChunk(address _chunk) public onlyOwner {
        chunk = IChunk(_chunk);
    }

    function getCountByToken(uint _tokenId) override public view returns (uint8) {
        return counts[_tokenId];
    }

    function getBuildingInfo(uint _tokenId, uint8 _idx) public view returns (BuildingInfo memory) {
        require(counts[_tokenId] > _idx, "BUILDING DOES NOT EXIST");
        return infos[_tokenId][_idx];
    }

    function _build(uint _tokenId, uint8 _tier) internal tokenExists(_tokenId) {
        BuildingInfo memory newBuilding = BuildingInfo(block.timestamp, _tier);
        infos[_tokenId][counts[_tokenId]] = newBuilding;
        counts[_tokenId] += 1;
    }

    function build(uint _tokenId, uint8 _tier) public virtual override onlyBuildingManager {}
}
