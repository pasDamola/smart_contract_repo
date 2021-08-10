// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Escrow {
    address public depositor;
    address payable public beneficiary;
    address public arbiter;

    constructor(address _arbiter, address _beneficiary) payable {
        arbiter = _arbiter;
        beneficiary = payable(_beneficiary);
        depositor = msg.sender;
    }

    modifier onlyArbiter(){
        require(msg.sender == arbiter);
        _;
    }

    function approve() external onlyArbiter {
        beneficiary.transfer(address(this).balance);
    }
}