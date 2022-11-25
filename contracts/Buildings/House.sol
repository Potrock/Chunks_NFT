// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.9;

// import "./Building.sol";
// import "../NFT/ICity.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";

// contract House is Building, Ownable {

//     constructor(address _buildingManager, address _city) Building(_buildingManager, _city) {
//     }

//     function buildAmount(uint _tokenId, uint _num) onlyBuildingManager public {
//         _buildAmount(_tokenId, _num);
//     }

//     function destroyAmount(uint _tokenId, uint _num) onlyBuildingManager public {
//         _destroyAmount(_tokenId, _num);
//     }
// }
