// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "../Buildings/IChunk_Building.sol";
import "../NFT/IChunk.sol";
import "./IFood.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Enumerable.sol";

contract Food is Ownable {
    address private farm;
    IERC721Enumerable private chunk;

    mapping(uint256 => uint256) public balances;
    mapping(uint256 => uint256) public claimTimes;

    constructor(address _chunkContract, address _farm) {
        chunk = IERC721Enumerable(_chunkContract);
        farm = _farm;
    }

    function setFarm(address _farm) public onlyOwner {
        farm = _farm;
    }

    function getEligibleFood(uint _tokenId) public view returns (uint) {
        if (claimTimes[_tokenId] == 0) {
            return 0;
        }

        //1 food per minute per farm
        return ((block.timestamp - claimTimes[_tokenId]) / 60) * IChunk_Building(farm).getCountByToken(_tokenId);
    }

    function harvest(uint _tokenId) public {
        require(chunk.ownerOf(_tokenId) == msg.sender || msg.sender == farm, "NOT OWNER");
        uint claimable = getEligibleFood(_tokenId);
        claimTimes[_tokenId] = block.timestamp;
        if (claimable > 0) {
            balances[_tokenId] += claimable;
        }
    }
}