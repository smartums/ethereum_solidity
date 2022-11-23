//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract COllegeTracker{

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

    function addNewCollege(string memory _collegeName, string memory _regNo, address _collegeAddress) public{
        colleges[_collegeAddress].name = _collegeName;
        colleges[_collegeAddress].collegeAddress = _collegeAddress;
        colleges[_collegeAddress].regNo = _regNo;
        colleges[_collegeAddress].collegeAdmin = msg.sender;
    }

    function getCollegeDetails(address _collegeAddress) public view returns(string memory, string memory, bool, uint8){
        return (
            colleges[_collegeAddress].name,
            colleges[_collegeAddress].regNo,
            colleges[_collegeAddress].addStudentPrivilege,
            colleges[_collegeAddress].noOfStudents
        );
    }    

    function blockCollegeAddingNewStudents(address _collegeAddress) public{
        colleges[_collegeAddress].addStudentPrivilege = false;
    } 

    function allowCollegeAddingNewStudents(address _collegeAddress) public{
        colleges[_collegeAddress].addStudentPrivilege = true;
    }

    function addNewStudent(address _collegeAddress, string memory _studentName, string memory _phoneNo, string memory _courseName) public{
        require(colleges[_collegeAddress].addStudentPrivilege, "Student registration not allowed in selected college!");
        
        students[_studentName].name = _studentName;
        students[_studentName].collegeAddress = _collegeAddress;
        students[_studentName].phoneNo = _phoneNo;
        students[_studentName].courseName = _courseName;

        colleges[_collegeAddress].noOfStudents = colleges[_collegeAddress].noOfStudents+1;
    }

    function changeStudentCourse(address _collegeAddress, string memory _studentName, string memory _newCourseName) public{
        students[_studentName].collegeAddress = _collegeAddress;
        students[_studentName].courseName = _newCourseName;
        colleges[_collegeAddress].noOfStudents = colleges[_collegeAddress].noOfStudents+1;
    }

    function getStudentDetails(string memory _studentName) public view returns(string memory, string memory, string memory){
        return (
            students[_studentName].name,
            students[_studentName].courseName,
            students[_studentName].phoneNo
        );
    }
}