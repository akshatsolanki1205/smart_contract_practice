//SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract bank {

    struct account {
        address owner;
        uint balance;
        uint accountcreatedTime;
    }

    mapping(address=> account) public LaxmiChitFund;

    event deposit(address owner, uint amount, uint timestamp);
    event withdrawal(address owner, uint amount, uint timestamp);

    //account creation

    function creatAccount() public payable {
        require(msg.value < 1 ether, "minimum requirement not fulfilled");
        
    }



}