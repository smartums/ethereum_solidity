//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ArrayDemo{
    // Array --> Fixed and Dynamic

    //Fixed length array
    uint8[50] ages;

    function setData(uint8 _index, uint8 _value) public {
        ages[_index] = _value;
    }

    function readData(uint8 _index) public view returns(uint8){
        return ages[_index];
    }


    //Dynamic array

    uint[] phoneNos;

    function setPhoneData(uint _phoneNo) public {
        phoneNos.push(_phoneNo);
    }

    function readPhoneNo(uint8 _index) public view returns(uint){
        return phoneNos[_index];
    }
}