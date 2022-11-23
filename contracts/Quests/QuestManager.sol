// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Roles.sol";

contract QuestManager is Roles {
    using Roles for Roles.Role;

    Roles.Role private quests;
    Roles.Role private admins;
    
    constructor(address[] memory _quests, address[] memory _admins) {
        for (uint256 i = 0; i < _quests.length; i++) {
            quests.add(_quests[i]);
        }

        for (uint256 i = 0; i < _admins.length; i++) {
            admins.add(_admins);
        }
    }

    function registerQuest(address _quest) {
        require(admins.has(msg.sender), "NOT ADMIN");

        quests.add(_quest);
    }

    function removeQuest(address _quest) {
        require(admins.has(msg.sender), "NOT ADMIN");

        quests.remove(_quest);
    }

    function runQuest(address _quest) {
        require(quests.has(_quest), "NOT APPROVED QUEST");
        
    }
}