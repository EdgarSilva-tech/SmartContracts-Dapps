// SPDX-License-Identifier: MIT

pragma solidity 0.8.11;

contract Auction {
    mapping (address => uint) public MyBid; 
    uint public InitialBid;
    uint index;
    address payable public owner;
    uint [] public bids;

    constructor(uint _FirstBid) {
        owner = payable(msg.sender);
        InitialBid = _FirstBid;
        index = 0;
        bids.push(InitialBid);
    }

    modifier HigherThanLast(uint _Bid) {
        require(_Bid > bids[index], "Please make a bid higher than the last one");
        _;
    }

    modifier WinnerBid {
        //require(msg.value == bids[index], "Only the winning bid of the auction can be submitted");
        require(MyBid[msg.sender] == bids[index], "Only the winning address can call this function");
        _;
    }

    modifier DeadLine {
        require(block.timestamp < block.timestamp + 1 hours, "The auction is finished!");
        _;
    }

    function Bid(uint _bid) public HigherThanLast(_bid) DeadLine {
        MyBid[msg.sender] = _bid;
        bids.push(_bid);
        index++;
    }

    function currentBid() public view returns (uint) {
        return bids[index];
    }

    function winner() payable external WinnerBid {
        owner.transfer(msg.value);
    }
}
