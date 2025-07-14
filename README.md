## Solidity interview DeFi engineer

### Exercise 1: Vault Attack

VaultAttack.s.sol script claims ether from the vault by reading `hiddenPassword` and `salt` from private vars.

## Exercise 2: Unexpected Ether

### SimpleGameAttacker.sol
A contract that demonstrates an attack on `SimpleGame`. It uses `EtherSender` to forcibly send Ether to the game contract, reaching the 1 Ether threshold without following the intended deposit logic, and then claims the reward.

### EtherSender.sol
A utility contract that allows forcibly sending Ether to any address using the `selfdestruct` opcode. This is useful for bypassing normal transfer restrictions and is often used in attack or test scenarios.

### SimpleGame.sol
An original simple game contract

### SimpleGameFixed.sol
An improved version of `SimpleGame` that tracks the total deposited amount internally, rather than relying on the contract's Ether balance. This prevents attacks that use forced Ether transfers to bypass the deposit logic.
