// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../Buildings/Building.sol";
import "../NFT/IChunk.sol";

contract Unit is Ownable {
    Building public spawner;
    IChunk public chunk;

    /**
     * tokenId -> balance
     */
    mapping(uint256 => uint256) public balances;

    constructor(address _chunkContract, address _spawner) {
        chunk = IChunk(_chunkContract);
        spawner = Building(_spawner);
    }

    modifier onlySpawner() {
        require(msg.sender == address(spawner));
        _;
    }

    modifier onlyTokenOwner(uint _tokenId) {
        require(chunk.ownerOf(_tokenId) == msg.sender);
        _;
    }

    function setSpawner(address _spawner) public onlyOwner {
        spawner = Building(_spawner);
    }

    function setChunk(address _chunk) public onlyOwner {
        chunk = IChunk(_chunk);
    }

    function getBalance(uint _tokenId) public view returns (uint) {
        return balances[_tokenId];
    }

    function addBalance(uint _tokenId, uint _amount) public onlySpawner {
        balances[_tokenId] += _amount;
    }

    function burnBalance(uint _tokenId, uint _amount) public onlySpawner {
        balances[_tokenId] -= _amount;
    }

    function transfer(
        uint _fromId,
        uint _toId,
        uint _amount
    ) public onlyTokenOwner(_fromId) {
        require(balances[_fromId] >= _amount, "INSUFFICIENT_UNITS");
        balances[_fromId] -= _amount;
        balances[_toId] += _amount;
    }
}
