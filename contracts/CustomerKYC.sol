//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract CustomerKYC {
    address rbiAddress;

    constructor() {
        rbiAddress = msg.sender;
    }

    modifier OnlyAdmin() {
        require(
            msg.sender == rbiAddress,
            "Only ADMIN can perform this action!"
        );
        _;
    }

    modifier OnlyBank() {
        require(
            msg.sender != rbiAddress,
            "Only Bank can perform this Action!"
        );
        _;
    }

    modifier isAddCustomerPrivileged() {
        require(
            banks[msg.sender].addCustomerPrivilege,
            "You don't have permission to add new customers, Please contact to RBI ADMIN!"
        );
        _;
    }

    modifier isKycPrivileged() {
        require(
            banks[msg.sender].kycPrivilege,
            "You don't have permission to perform customer KYC, Please contact to RBI ADMIN!"
        );
        _;
    }

    modifier isValidBankCustomer(string memory custName) {
        require(
            msg.sender == customers[custName].bankAddress,
            "Customer doesn't exist in your bank!"
        );
        _;
    }

    struct Bank {
        address bankAddress;
        string name;
        uint8 kycCount;
        bool addCustomerPrivilege;
        bool kycPrivilege;
    }

    struct Customer {
        string name;
        string data;
        address bankAddress;
        string bankName;
        bool kycStatus;
    }

    mapping(address => Bank) banks;
    mapping(string => Customer) customers;

    function addNewbank(string memory _name, address _bankAddress) public OnlyAdmin {
        banks[_bankAddress].bankAddress = _bankAddress;
        banks[_bankAddress].name = _name;
    }

    function addNewCustomer(string memory _name, string memory _data)
        public
        OnlyBank
        isAddCustomerPrivileged
    {
        customers[_name].name = _name;
        customers[_name].data = _data;
        customers[_name].bankAddress = msg.sender;
        customers[_name].bankName = banks[msg.sender].name;
    }

    function getKycStatus(string memory _name)
        public
        view
        OnlyBank
        returns (bool kycStatus)
    {
        return (customers[_name].kycStatus);
    }

    function performKyc(string memory _name)
        public
        OnlyBank
        isValidBankCustomer(_name)
        isKycPrivileged
    {
        customers[_name].kycStatus = true;
        banks[msg.sender].kycCount += 1;
    }

    function blockBankToAddNewCustomer(address _bankAddress) public OnlyAdmin {
        banks[_bankAddress].addCustomerPrivilege = false;
    }

    function blockBankToPerformKyc(address _bankAddress) public OnlyAdmin {
        banks[_bankAddress].kycPrivilege = false;
    }

    function allowBankToAddNewCustomer(address _bankAddress) public OnlyAdmin {
        banks[_bankAddress].addCustomerPrivilege = true;
    }

    function allowBankToPerformKyc(address _bankAddress) public OnlyAdmin {
        banks[_bankAddress].kycPrivilege = true;
    }

    function getCustomerData(string memory _name)
        public
        view
        OnlyBank
        returns (
            string memory name,
            string memory data,
            string memory bankName,
            bool kycStatus
        )
    {
        return (
            customers[_name].name,
            customers[_name].data,
            customers[_name].bankName,
            customers[_name].kycStatus
        );
    }

    function getBankDetails(address _bankAddress)
        public
        view
        OnlyAdmin
        returns (
            string memory name,
            uint8 kycCount,
            bool addCustomerPrivilege,
            bool kycPrivilege
        )
    {
        return (
            banks[_bankAddress].name,
            banks[_bankAddress].kycCount,
            banks[_bankAddress].addCustomerPrivilege,
            banks[_bankAddress].kycPrivilege
        );
    }
}
