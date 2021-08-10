// SPDX-License-Identifier: MIT
pragma solidity ^0.7.5;

contract Escrow {
    address public depositor;
    address payable public beneficiary;
    address public arbiter;

    constructor(address _arbiter, address _beneficiary) payable {
        arbiter = _arbiter;
        beneficiary = payable(_beneficiary);
        depositor = msg.sender;
    }

    function approve() external {
        beneficiary.transfer(address(this).balance);
    }
}