//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Variables{
    // Variable samples

    //Integer variables--> signed and unsigned integers
    //Signed Integers--> +ve and -ve values both
    //Unsigned Integers--> only +ve values
    //uint 256 --> 0.1 kb
    //0 to 255 --> 0.001kb

    uint8 age;
    uint16 height;
    uint64 amount;
    uint128 field1;
    uint256 field2;

    //string variables--> bytes & string
    bytes4 name = "MKS1"; //Only up to 4 characters
    bytes32 name1 = "Mukesh Singh"; // Up to 32 characters

    // bool variable -->. true or false
    bool isDone = true;

    //No double or float values

}