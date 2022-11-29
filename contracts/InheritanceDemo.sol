//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Parent{
    string name;

    function setName(string memory _name) public {
        name = _name;
    }
}

contract Child is Parent{
    
    function getName() public view returns(string memory){
        return name;
    }
    
}