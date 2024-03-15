// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract VendingMachine {
    address public owner;
    mapping (address => uint256) public donutBalances;

    constructor() {
        owner = msg.sender;
        donutBalances[address(this)] = 100;   
    }

    function getVendingMachineBalance() public view returns (uint256) {
        return donutBalances[address(this)];   
    }

    function restock(uint256 amount) public {
        require(msg.sender == owner, "Only the owner can restock the machine!");
        donutBalances[address(this)] += amount;
    }

    function purchase(uint amount) public payable {
        require(msg.value >=amount * 0.1 ether, "Pay the full amount for the donut!");
        require(donutBalances[address(this)] >= amount, "Not enough donuts in stock to sell!");
        donutBalances[address(this)] -= amount;
        donutBalances[msg.sender] += amount;
    } 
}