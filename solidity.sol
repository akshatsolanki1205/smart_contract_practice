//SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract bank {
    struct account {
        address owner;
        uint balance;
        uint accountcreationTime;
    }

    mapping(address => account) public LaxmiChitFund;

    event deposit(address owner, uint amount, uint timestamp);
    event withdrawal(address owner, uint amount, uint timestamp);

    modifier minimum() {
        require(msg.value > 1 ether, "minimum requirement not fulfilled");
        _;
    }

    //account creation

    function creatAccount() public payable minimum {
        account memory A;
        A.owner = msg.sender;
        A.balance += msg.value;
        A.accountcreationTime = block.timestamp;
        LaxmiChitFund[msg.sender] = A;
        emit deposit(msg.sender, msg.value, block.timestamp);
    }

    // deposit

    function depositing() public payable minimum {
        LaxmiChitFund[msg.sender].balance += msg.value;
        emit deposit(msg.sender, msg.value, block.timestamp);
    }

    // withdraw

    function withdraw(uint amount) public payable {
        require(
            amount < LaxmiChitFund[msg.sender].balance,
            " not sufficient balance"
        );
        payable(msg.sender).transfer(amount);
        LaxmiChitFund[msg.sender].balance -= amount;
        emit withdrawal(msg.sender, amount, block.timestamp);
    }
}
