pragma solidity ^0.8.7;

contract MoneySample{
    address owner = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;

    function getMoney() public payable{}

    fallback() external payable{}

    function checkContractBalance() public view returns(uint){
        return address(this).balance;
    }

    function transferToAddress() public {
        payable(owner).transfer(address(this).balance);
    }

    function checkAddressBalance() public view returns(uint){
        return owner.balance;
    }
}