import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Enumerable.sol";

interface ICity {
    function tokenExists(uint _tokenId) external view returns (bool);
    function ownerOf(uint256 tokenId) external view returns (address owner);
}