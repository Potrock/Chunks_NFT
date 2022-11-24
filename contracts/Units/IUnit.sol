// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IUnit {
    function addBalance(uint _tokenId, uint _amount) external;
    function burnBalance(uint _tokenId, uint _amount) external;
}