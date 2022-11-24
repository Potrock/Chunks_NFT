// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./Building.sol";
import "../NFT/IChunk.sol";
import "../Units/IFood.sol";

contract Farm is Building, Ownable {
    IFood private food;

    mapping(uint => uint256) claimTimes;

    constructor(address _buildingManager, address _chunk) Building(_buildingManager, _chunk) {
    }

    function setFood(address _food) public onlyOwner {
        food = IFood(_food);
    }

    function getCountByToken(uint _tokenId) public view returns (uint) {
        return counts[_tokenId];
    }

    function buildAmount(uint _tokenId, uint _num) public onlyBuildingManager {
        require(food != address(0), "FOOD_NOT_SET")
        food.harvest(_tokenId);
        _buildAmount(_tokenId, _num);
    }

    function destroyAmount(uint _tokenId, uint _num)
        public
        onlyBuildingManager
    {
        _destroyAmount(_tokenId, _num);
    }
}
