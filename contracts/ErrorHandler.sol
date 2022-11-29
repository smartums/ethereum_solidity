//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ErrorHandlerDemo{
    uint balance = 100;

    function deductBalRevert(uint _amount) public returns(uint){
        if(_amount < 2){
            revert("Input amount is not valid!");
        }

        balance = balance - _amount;
        return balance;
    }

    function deductBalRequire(uint _amount) public returns(uint){
        require(_amount > 1, "Input amount is not valid!");

        balance = balance - _amount;
        return balance;
    }

    function deductBalAssert(uint _amount) public returns(uint){
        assert(_amount > 1);

        balance = balance - _amount;
        return balance;
    }
}