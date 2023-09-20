// SPDX-License-Identifier: MIT

pragma solidity 0.8.11;

contract Ballot {
    address voter;
    mapping (string => uint) voteCount;
    mapping (address => bool) hasVoted;
    string [] parties = ["PS", "PSD", "CHEGA", "IL", "BE", "CDU", "PAN", "LIVRE", "CDS"];

    modifier inBallot (string memory _party, uint _index) {
        require(keccak256(abi.encodePacked(parties[_index])) == keccak256(abi.encodePacked(_party)), "Please vote for a party in the ballot with the correct index!");
        _;
    }

    function vote(string memory _party, uint _index) external inBallot(_party, _index) {
        require(hasVoted[msg.sender] == false, "You have already voted!");
        voteCount[_party]++;
        voted(msg.sender);
    }

    function getVoteCount(string memory _party) public view returns(uint) {
        return voteCount[_party];
    }

    function voted(address _voter) private {
        hasVoted[_voter] = true;
    }
}
