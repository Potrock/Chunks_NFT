// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./IChunk_Descriptor.sol";

contract Chunk_Descriptor is Ownable, IChunk_Descriptor {
    string private baseURI;

    constructor(string memory _baseURI) {
        baseURI = _baseURI;
    }

    function getTokenURI(uint _tokenId) override public view returns (string memory) {
        return string(abi.encodePacked(baseURI, _tokenId));
    }
}