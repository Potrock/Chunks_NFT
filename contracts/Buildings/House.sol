// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.9;

// import "./Building.sol";
// import "../NFT/IChunk.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";

// contract House is Building, Ownable {

//     constructor(address _buildingManager, address _chunk) Building(_buildingManager, _chunk) {
//     }

//     function buildAmount(uint _tokenId, uint _num) onlyBuildingManager public {
//         _buildAmount(_tokenId, _num);
//     }

//     function destroyAmount(uint _tokenId, uint _num) onlyBuildingManager public {
//         _destroyAmount(_tokenId, _num);
//     }
// }
