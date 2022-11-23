// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Roles.sol";

contract Food is ERC20Burnable, Roles {
    using Roles for Roles.Role;
    Roles.Role private minter;
    Roles.Role private burner;

    constructor(address _farmContract) ERC20("Chunk Food", "FOOD") {
        minter.add(_farmContract);
        burner.add(_farmContract);
    }

    function burnFrom(address account, uint256 amount) override public virtual {

    }
}