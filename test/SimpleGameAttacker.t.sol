// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {Test, console} from "forge-std/Test.sol";
import {SimpleGame} from "../src/SimpleGame.sol";
import {SimpleGameAttacker} from "../src/SimpleGameAttacker.sol";
import {SimpleGameFixed} from "../src/SimpleGameFixed.sol";

contract SimpleGameAttackerTest is Test {
    SimpleGame public simpleGame;
    SimpleGameFixed public simpleGameFixed;
    SimpleGameAttacker public attacker;
    address public caller;

    function setUp() public {
        simpleGame = new SimpleGame();
        simpleGameFixed = new SimpleGameFixed();
        attacker = new SimpleGameAttacker();
        caller = makeAddr("caller");
        vm.deal(caller, 10 ether);
    }

    function test_AttackSimpleGame() public {
        // deposit 0.1 ether to the game
        uint256 depositAmount = 0.1 ether;
        simpleGame.deposit{value: depositAmount}();
        vm.startPrank(caller);
        // calculate the amount of ether to add to the attacker to force send ether to the game
        uint256 amountToAdd = 1 ether - address(simpleGame).balance;
        // attack the game
        uint256 callerBalanceBefore = address(caller).balance;
        attacker.attack{value: amountToAdd}(address(simpleGame));
        // assert the game is finished and the caller received the ether
        assertEq(simpleGame.isFinished(), true);
        assertEq(address(caller).balance, callerBalanceBefore + depositAmount);
        vm.stopPrank();
    }

    function test_Revert_AttackSimpleGameFixed() public {
        uint256 depositAmount = 0.1 ether;
        simpleGameFixed.deposit{value: depositAmount}();
        vm.startPrank(caller);
        // calculate the amount of ether to add to the attacker to force send ether to the game
        uint256 amountToAdd = 1 ether - address(simpleGameFixed).balance;
        // game attack should fail
        vm.expectRevert();
        attacker.attack{value: amountToAdd}(address(simpleGameFixed));
        vm.stopPrank();
    }

}
