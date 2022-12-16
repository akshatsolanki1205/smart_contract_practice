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
    mapping(address => uint) public total;

    // auction still open
    bool public bidding = true;

    // highest bid
    bidInfo public highestbid;

    //logs
    event newBid(address bidder, uint bid);

    // bid
    function bid() public payable {
        require(msg.value > highestbid.amount, "your bid is not the highest");
        highestbid.bidder = msg.sender;
        total[msg.sender] += msg.value;
        highestbid.amount = total[msg.sender];
        emit newBid(msg.sender, msg.value);
    }

    //check your bid
    function myBid() public view returns (uint) {
        return total[msg.sender];
    }

    // end auction
    function end() public {
        require(msg.sender == owner, "only actioneer can end the auction");
        bidding = false;
    }

    // withdraw
    function withdraw() public payable {
        require(bidding == false, "bidding hasn't ended yet");
        require(
            msg.sender != highestbid.bidder,
            "you can't withdraw your are the winner"
        );
        payable(msg.sender).transfer(total[msg.sender]);
    }
}
