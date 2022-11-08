// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract Token {
    
    string public name = "adescoin";
    string public symbol = "ADCN";

    uint256 public totalSupply = 10000;

    // tHE address type variable used to store ethereum accounts.
    address public owner;

    // A storage of each account's balance.
    mapping(address => uint256) balances;

    // This Transfer event helps off-chain applications understand
    // what is happening within this contract.
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    /**
     * initializating the contract.
     */
    constructor() {
        // The totalSupply is assigned to the transaction sender, which is the
        // my accountas the deployer of the contract.
        balances[msg.sender] = totalSupply;
        owner = msg.sender;
    }

    /*
    A function to transfer tokens.
    The `external` modifier makes the function *only* callable from outside the contract.
    */
    function transfer(address to, uint256 amount) external {
        // Ascertain that the transaction sender has enough tokens to send.
        // If the first argument in `require` evaluates to `false` then the transaction reverts.
        require(balances[msg.sender] >= amount, "Insufficient token balance");

        // Effect the transfer of an amount
        balances[msg.sender] -= amount;
        balances[to] += amount;

        // Notify off-chain applications of a successful transfer.
        emit Transfer(msg.sender, to, amount);
    }

    /*
    This read-only function retrieves the token balance of an account.
    The `view` modifier indicates that it doesn't modify the contract's
    state, making it possible to call it without executing a transaction.
    */

    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }
}
