// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./ICity_Building.sol";
import "../NFT/ICity.sol";

contract BuildingManager is Ownable {

    ICity public city;
    mapping(uint => address) public buildingContracts;
    uint public numBuildings;

    event BuildingAdded(uint _buildingId, uint indexed _tokenId, uint8 _tier);

    constructor(address _city) {
        city = ICity(_city);
    }

    modifier buildingExists(uint _buildingId) {
        require(buildingContracts[_buildingId] != address(0), "Building does not exist");
        _;
    }

    modifier tokenExists(uint _tokenId) {
        require(city.tokenExists(_tokenId), "Token does not exist");
        _;
    }

    function registerBuilding(address _address) public onlyOwner {
        buildingContracts[numBuildings] = _address;
        numBuildings++;
    }

    function addBuildingTo(uint _buildingId, uint _tokenId, uint8 _tier) public onlyOwner buildingExists(_buildingId) tokenExists(_tokenId) {
        ICity_Building(buildingContracts[_buildingId]).build(_tokenId, _tier);
        emit BuildingAdded(_buildingId, _tokenId, _tier);
    }

    function getBuildingCountById(uint _buildingId, uint _tokenId) public view buildingExists(_buildingId) tokenExists(_tokenId) returns (uint) {
        return ICity_Building(buildingContracts[_buildingId]).getCountByToken(_tokenId);
    }
}