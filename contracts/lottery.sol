//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8;

contract Lotery {
    address public manager;
    address [] public participants;
    
    constructor () {
        manager = msg.sender;
    }
    
    function enterLottery () public payable {
        require (msg.value>1 ether);
        participants.push(msg.sender);
    }
    
    function pickWinner () public {
        require(msg.sender == manager);
        uint index = random() % participants.length;
        payable(participants[index]).transfer(address(this).balance);
        participants = new address[](0);
        
    }
    
    function random() private view returns (uint256){
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participants)));
    }
}
