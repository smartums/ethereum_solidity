//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract CustomerKYC {
    address centralBankAddress;

    constructor() {
        centralBankAddress = msg.sender;
    }

    modifier OnlyAdmin() {
        require(
            msg.sender == centralBankAddress,
            "You are not an admin to perform this action."
        );
        _;
    }

    modifier OnlyBank() {
        require(
            msg.sender != centralBankAddress,
            "Admin can't perform this action."
        );
        _;
    }

    modifier isAddCustomerPrivileged() {
        require(
            banks[msg.sender].addCustomerPrivilege,
            "Bank is not allowed to add new customer."
        );
        _;
    }

    modifier isKycPrivileged() {
        require(
            banks[msg.sender].kycPrivilege,
            "Bank is not allowed to perform Kyc."
        );
        _;
    }

    modifier isValidBankCustomer(string memory custName) {
        require(
            msg.sender == customers[custName].bankId,
            "Customer doesn't belong to this bank"
        );
        _;
    }

    struct Bank {
        address id;
        string name;
        uint8 kycCount;
        bool addCustomerPrivilege;
        bool kycPrivilege;
    }

    struct Customer {
        string name;
        string data;
        address bankId;
        string bankName;
        bool kycStatus;
    }

    mapping(address => Bank) banks;
    mapping(string => Customer) customers;

    function addNewbank(string memory _name, address _id) public OnlyAdmin {
        banks[_id].id = _id;
        banks[_id].name = _name;
        banks[_id].addCustomerPrivilege = true;
        banks[_id].kycPrivilege = true;
    }

    function addNewCustomer(string memory _name, string memory _data)
        public
        OnlyBank
        isAddCustomerPrivileged
    {
        //require(banks[msg.sender].addCustomerPrevilidge,"Bank is not allowed to add new customer.");
        customers[_name].name = _name;
        customers[_name].data = _data;
        customers[_name].bankId = msg.sender;
        customers[_name].bankName = banks[msg.sender].name;
        //customers[_name].kycStatus = false;
    }

    function checkKycSattus(string memory _name)
        public
        view
        OnlyBank
        returns (bool kycStatus)
    {
        //require(customers[_name], "Customer doesn't exist.");
        return (customers[_name].kycStatus);
    }

    function updateKyc(string memory _name)
        public
        OnlyBank
        isValidBankCustomer(_name)
        isKycPrivileged
    {
        customers[_name].kycStatus = true;
        banks[msg.sender].kycCount += 1;
    }

    function blockBankToAddNewCustomer(address _id) public OnlyAdmin {
        banks[_id].addCustomerPrivilege = false;
    }

    function blockBankToPerformKyc(address _id) public OnlyAdmin {
        banks[_id].kycPrivilege = false;
    }

    function allowBankToAddNewCustomer(address _id) public OnlyAdmin {
        banks[_id].addCustomerPrivilege = true;
    }

    function allowBankToPerformKyc(address _id) public OnlyAdmin {
        banks[_id].kycPrivilege = true;
    }

    function viewCustomerData(string memory _name)
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

    function getBankDetails(address _id)
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
            banks[_id].name,
            banks[_id].kycCount,
            banks[_id].addCustomerPrivilege,
            banks[_id].kycPrivilege
        );
    }
}
