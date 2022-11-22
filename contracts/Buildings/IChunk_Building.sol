// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IChunk_Building {

    function getCountByToken(uint _tokenId) public view returns (uint);

    function buildAmount(uint _tokenId, uint _num) public;

    function destroyAmount(uint _tokenId, uint _num) public;
}