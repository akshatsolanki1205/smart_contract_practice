//SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract auction {

    //auctioneer and item
    address public owner;
    string public item;

    constructor(string memory _item) {
        owner = msg.sender;
        item = _item;
    }

    // properties of bidder
    struct bidInfo {
        address bidder;
        uint amount;
    }

    //history of bidding
    mapping (address => uint) public total;

    //every bidder
    address[] public participants;

    // auction still open
    bool public bidding = true;

    // highest bid
    bidInfo public highestbid;

    //logs
    event newBid(address bidder, uint bid);

    // bid
    function bid() payable public {
        require(msg.value > highestbid.amount , "your bid is not the highest");
        highestbid.bidder = msg.sender;
        highestbid.amount += msg.value;
        total[msg.sender] += msg.value;
        
        emit newBid(msg.sender, msg.value);
    }

    // end auction 
    function end() payable public {
        require(msg.sender == owner, "only actioneer can end the auction");
        bidding = false;
        

    }

    

    
    


}