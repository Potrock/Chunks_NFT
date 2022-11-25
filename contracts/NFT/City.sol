// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "../Descriptors/ICity_Descriptor.sol";
import "./ICity.sol";

contract City is ERC721Enumerable, Ownable, ReentrancyGuard {
    using SafeMath for uint256;
    uint public mintSupply;
    uint public totalMinted = 0;
    ICity_Descriptor private descriptor;

    constructor(uint _mintSupply, address _descriptor) ERC721("CryptoCity", "CryptoCity") {
        mintSupply = _mintSupply;
        descriptor = ICity_Descriptor(_descriptor);
    }

    function setDescriptor(address _descriptor) public onlyOwner {
        descriptor = ICity_Descriptor(_descriptor);
    }

    function tokenURI(uint _tokenId) override public view returns (string memory) {
        require(_exists(_tokenId), "ERC721Metadata: URI tokenId nonexistent");

        return descriptor.getTokenURI(_tokenId);
    }

    function mint() public {
        require(totalMinted < mintSupply, "All tokens minted");

        _safeMint(msg.sender, totalMinted);
        totalMinted++;
    }

    function tokenExists(uint _tokenId) external view returns (bool) {
        return _exists(_tokenId);
    }
    
}
