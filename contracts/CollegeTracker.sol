//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract COllegeTracker{
    address universityAddress;

    constructor() {
        universityAddress = msg.sender;
    }

    struct College{
        string name;
        address collegeAddress;
        address collegeAdmin;
        string regNo;
        bool addStudentPrivilege;
        uint8 noOfStudents;
    }

    struct Student{
        address collegeAddress;
        string name;
        string phoneNo;
        string courseName;
    }

    mapping(address => College) colleges;
    mapping(string => Student) students;

    modifier OnlyUniversityAdmin() {
        require(
            msg.sender == universityAddress,
            "Only University ADMIN can perform this action!"
        );
        _;
    }

    modifier OnlyCollegeAdmin(address _collegeAddress) {
        require(
            msg.sender == _collegeAddress,
            "Only college ADMIN can perform this action!"
        );
        _;
    }

    modifier OnlyCollegeAdminOrUniAdmin(address _collegeAddress) {
        require(
            msg.sender == _collegeAddress || universityAddress == msg.sender,
            "Only University or Same college ADMIN can perform this action!"
        );
        _;
    }

    modifier isAllowedToAddNewStudents(address _collegeAddress){
        require(
            colleges[_collegeAddress].addStudentPrivilege,
            "College is not authorized to add new Student!"
        );
        _;
    }

    function addNewCollege(
        string memory _collegeName, 
        string memory _regNo, 
        address _collegeAddress) 
        public OnlyUniversityAdmin{

        colleges[_collegeAddress].name = _collegeName;
        colleges[_collegeAddress].collegeAddress = _collegeAddress;
        colleges[_collegeAddress].regNo = _regNo;
        colleges[_collegeAddress].collegeAdmin = msg.sender;
    }

    function getCollegeDetails(address _collegeAddress) 
        public 
        view
        OnlyCollegeAdminOrUniAdmin(_collegeAddress)
        returns(string memory collegeName, string memory registrationNo, bool addStudentPrivilege, uint8 noOfStudents){
        return (
            colleges[_collegeAddress].name,
            colleges[_collegeAddress].regNo,
            colleges[_collegeAddress].addStudentPrivilege,
            colleges[_collegeAddress].noOfStudents
        );
    }    

    function blockCollegeAddingNewStudents(address _collegeAddress) public OnlyUniversityAdmin{
        colleges[_collegeAddress].addStudentPrivilege = false;
    } 

    function allowCollegeAddingNewStudents(address _collegeAddress) public OnlyUniversityAdmin{
        colleges[_collegeAddress].addStudentPrivilege = true;
    }

    function addNewStudent(
        address _collegeAddress, 
        string memory _studentName, 
        string memory _phoneNo, 
        string memory _courseName) 
        OnlyCollegeAdminOrUniAdmin(_collegeAddress)
        isAllowedToAddNewStudents(_collegeAddress)
        public{
        
        students[_studentName].name = _studentName;
        students[_studentName].collegeAddress = _collegeAddress;
        students[_studentName].phoneNo = _phoneNo;
        students[_studentName].courseName = _courseName;

        colleges[_collegeAddress].noOfStudents = colleges[_collegeAddress].noOfStudents+1;
    }

    function changeStudentCourse(
        address _collegeAddress, 
        string memory _studentName, 
        string memory _newCourseName) 
        OnlyCollegeAdminOrUniAdmin(_collegeAddress)
        public{
        students[_studentName].collegeAddress = _collegeAddress;
        students[_studentName].courseName = _newCourseName;
        colleges[_collegeAddress].noOfStudents = colleges[_collegeAddress].noOfStudents+1;
    }

    function getStudentDetails(string memory _studentName) 
        public 
        view 
        OnlyCollegeAdminOrUniAdmin(students[_studentName].collegeAddress)
        returns(string memory studentName, string memory courseName, string memory phoneNo){
        return (
            students[_studentName].name,
            students[_studentName].courseName,
            students[_studentName].phoneNo
        );
    }
}