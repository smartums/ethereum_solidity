//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ModifierDemo{

    address public SimpliLearn;

    constructor() public{
        //0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
        SimpliLearn = msg.sender;
    }

    modifier onlySimpliLearn(){
        require(msg.sender == SimpliLearn);
        _;
    }

    struct learner {
        string name;
        uint8 age;
        //uint32 phoneNo;
        //string addresses;
    }

    //To assigne an ID to each lerner
    // 1 => ("MKS1", 30)
    // 2 => ("MKS2", 33)
    mapping(uint8 => learner) learners;

    function setLearner(uint8 _key, string memory _name, uint8 _age) public onlySimpliLearn{
        learners[_key].name = _name;
        learners[_key].age = _age;
    }

    function getLearner(uint8 _key) public view returns(string memory, uint8){
        return (
            learners[_key].name,
            learners[_key].age
        );
    }
}