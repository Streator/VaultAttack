// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

// This contract is used to force send ether to a receiver
contract EtherSender {
    function forceSendEther(address payable receiver) public payable {
        selfdestruct(receiver);
    }
}
