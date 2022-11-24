// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./Building.sol";
import "../NFT/IChunk.sol";
import "../Units/IUnit.sol";

contract Farm is Building {

    IUnit private food;

    constructor(address _buildingManager, address _chunk) Building(_buildingManager, _chunk) {
    }

    function setFood(address _food) public onlyOwner {
        food = IUnit(_food);
    }

    function build(uint _tokenId, uint8 _tier) override public onlyBuildingManager {
        require(address(food) != address(0), "FOOD NOT SET");
        _build(_tokenId, _tier);
    }

    function getEligibleFood(uint _tokenId, uint8 _idx) public view returns (uint) {

        BuildingInfo memory info = getBuildingInfo(_tokenId, _idx);
        if (info.interactTimestamp == 0) {
            return 0;
        }
        return
            ((block.timestamp - info.interactTimestamp) / 1 minutes) * (info.tier + 1);
    }

    function harvest(uint _tokenId, uint8 _idx) public onlyTokenOwner(_tokenId) {
        uint8 counts = getCountByToken(_tokenId);
        require(counts > _idx, "FARM DOES NOT EXIST");

        uint harvestableFood = getEligibleFood(_tokenId, _idx);
        require(harvestableFood > 0, "NO FOOD READY");

        food.addBalance(_tokenId, harvestableFood);
        infos[_tokenId][_idx].interactTimestamp = block.timestamp;
    }
}
