// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract IFood {
    function harvest(uint _tokenId) public {}
    function getEligibleFood(uint _tokenId) public view returns (uint) {}
}