// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DAppify{

    uint totalusers;
    uint totalRegisteredDapps;
    uint subscriptionPay = 1 ether;
    address subscrptionAddress = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    //struct of the user
    struct User{
        uint userId;
        string firstName;
        string secondName;
        string userName;
        uint Downloads;
        address myAddress;
    }

    //struct of registered dApp
    struct dApp{
        uint dAppId;
        string dAppName;
        string description;
        address dAppreg;
    }

    //mapping of dApps
    mapping(uint => dApp) dAppsMap;

    //mapping of username to User struct
    mapping (string => User) private ourUsers;

    //mapping of index of user struct
    mapping (uint => User) private users;

    //mappimg address and user
    mapping(address => User) private userAddress;

    //array of users
    User[] private userArray;

    //array of dApp
    dApp[] private dAppArray;

    //event for registered user
    event userRegistered(uint userId, string firstName ,string secondName, string userName ,uint Downloads ,address myAddress);

    //event for registered Dapp
    event dAppRegistered(uint dAppId, string dAppName, string description,address dAppreg);

    //function to register user
    function signUp(string memory _firstName, string memory _secondName, string memory _userName) public {
        require(!Exist(_userName), "username already taken");
        address _myAddress = msg.sender;
        uint _userId = totalusers++;
        ourUsers[_userName]= User(_userId,_firstName , _secondName, _userName,0, _myAddress);
        users[_userId] = User(_userId,_firstName , _secondName, _userName,0, _myAddress);
        userAddress[_myAddress] = User(_userId,_firstName , _secondName, _userName,0, _myAddress);
        emit userRegistered(_userId,_firstName , _secondName, _userName, 0,_myAddress);
        }

    //function to get user
    function getUser(string memory _userName) public view returns(User memory){
        return ourUsers[_userName];
    }

    //function to get total number of users
    function totalUsers() public view returns (uint) {
        return totalusers;
    }

    //function to get all users
    function getAllUsers() public view returns (User[] memory){
        User[] memory userList = new User[](totalusers);
        for (uint i = 0; i < totalusers; i++) {
            userList[i] = users[i];
        }
        return userList;
    }

    //function to register dApp
    function registerDapp(string memory _dAppName, string memory _description) public payable {

        address _dAppreg = msg.sender;
        require(msg.value == subscriptionPay, "Enter the correct price");
        (bool sent, ) = subscrptionAddress.call{value: msg.value}("");
        if (sent){
            uint _dAppId = totalRegisteredDapps++;
            dAppsMap[_dAppId]= dApp(_dAppId,_dAppName, _description , _dAppreg);
            emit dAppRegistered(_dAppId, _dAppName, _description, _dAppreg);
        } else {
            return;
        }    
    }

    //function to get registered dApp
    function getdApp(uint _dAppId) public view returns (dApp memory) {
        return dAppsMap[_dAppId];
    }

    //function to get all dApps
    function getAllDapps() public view returns (dApp[] memory){
        dApp[] memory dappList = new dApp[](totalRegisteredDapps);
        for (uint i = 0; i < totalRegisteredDapps; i++) {
            dappList[i] = dAppsMap[i];
        }
    return dappList;
    }

    //function to check if username exist
    function Exist(string memory _userName) private view returns (bool) {
        for(uint i = 0; i < totalusers; i++) {
        if(keccak256(bytes(users[i].userName)) == keccak256(bytes(_userName))){
            return true;
        }
    }
    return false;}

    //function to update downloads
    function download() public {
        require(registered(msg.sender), "Please signUp");
        userAddress[msg.sender].Downloads++;     
    }

    //function to check if address is registered
    function registered(address _myAdd) public view returns (bool) {
        for (uint i=0; i < totalusers; i++ ){
            if(users[i].myAddress == _myAdd){
                return true;
            }
        }
    return false;}


}