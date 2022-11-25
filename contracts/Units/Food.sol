// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "../Buildings/ICity_Building.sol";
import "../NFT/ICity.sol";
import "./Unit.sol";

contract Food is Unit {
    mapping(uint256 => uint256) public claimTimes;

    constructor(address _cityContract, address _farm)
        Unit(_cityContract, _farm)
    {}
}
