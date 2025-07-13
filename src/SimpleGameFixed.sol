// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract SimpleGameFixed {
    bool public isFinished;
    uint256 lastDepositedBlock;
    uint256 public depositAmount;

    function totalDeposit() external view returns (uint256) {
        return address(this).balance;
    } 

    function deposit() public payable {
        require(msg.value == 0.1 ether, "Must deposit 0.1 Ether");
        require(!isFinished, "The game is over");
        require(
            lastDepositedBlock != block.number,
            "Only can deposit once per block"
        );

        lastDepositedBlock = block.number;
        // we use depositAmount to track the total deposit amount
        depositAmount += msg.value;
    }

    function claim() public {
        require(depositAmount >= 1 ether, "Condition not satisfied");

        isFinished = true;
        depositAmount = 0;
        payable(msg.sender).transfer(depositAmount);
    }
}