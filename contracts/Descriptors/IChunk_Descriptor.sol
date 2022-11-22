// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";

interface IChunk_Descriptor {
    function getTokenURI(uint _tokenId) external view returns (string memory);
}