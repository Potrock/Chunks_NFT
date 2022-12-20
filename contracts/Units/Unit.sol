// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../NFT/ICity.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Unit is Ownable {
    address public spawner;
    ICity public city;

    /**
     * tokenId -> balance
     */
    mapping(uint256 => uint256) public balances;

    event Transfer(uint _fromId, uint _toId, uint _amount);

    constructor(address _cityContract, address _spawner) {
        city = ICity(_cityContract);
        spawner = _spawner;
    }

    modifier onlySpawner() {
        require(msg.sender == spawner);
        _;
    }

    modifier onlyTokenOwner(uint _tokenId) {
        require(city.ownerOf(_tokenId) == msg.sender);
        _;
    }

    function setSpawner(address _spawner) public onlyOwner {
        spawner = _spawner;
    }

    function setCity(address _city) public onlyOwner {
        city = ICity(_city);
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
        emit Transfer(_fromId, _toId, _amount);
    }
}
