pragma solidity ^0.4.24;

import "./ClubManager.sol";

contract MeetingManager is ClubManager{
    event meetingCreated(string _clubId, string _meetingId);
    event memberAddedInMeeting(string _clubId, string _meetingId, address _memberId);
    
    function meetingCreate(string _clubId, string _meetingId, uint256 _time, uint256 _balance) 
        public 
    {
        require(isClubIdExist(_clubId));
        require(isMemberIdExist(msg.sender));
        require(!isMeetingIdExist(_clubId, _meetingId, _time));
        require(club[stringToBytes32(_clubId)].authority[msg.sender] == 1);
        Meeting memory temp;
        bytes32 tempId = keccak256(_clubId, _meetingId, _time);
        temp.id = _meetingId;
        temp.time = _time;
        temp.balance = _balance;
        temp.clubId = _clubId;
        meeting[tempId] = temp;
        meeting[tempId].member.push(msg.sender);
        meeting[tempId].numberOfMember++;
        meetingIdArr.push(tempId);
        numberOfMeeting++;
        club[stringToBytes32(_clubId)].meeting.push(tempId);
        club[stringToBytes32(_clubId)].numberOfMeeting++;
        member[msg.sender].meeting.push(tempId);
        member[msg.sender].numberOfMeeting++;
        MemberState memory tempState;
        tempState.stake = 0;
        tempState.state = 0;
        meeting[tempId].memberState[msg.sender] = tempState;
        
        emit meetingCreated(_clubId, _meetingId);
    }
    
    function addMemberInMeeting(string _clubId, string _meetingId, uint256 _time, address _memberId) 
        public
    {
        require(isClubIdExist(_clubId));
        require(isMemberIdExist(msg.sender));
        require(isMeetingIdExist(_clubId, _meetingId, _time));
        require(club[stringToBytes32(_clubId)].authority[msg.sender] == 1);
        bytes32 tempId = keccak256(_clubId, _meetingId, _time);
        meeting[tempId].member.push(_memberId);
        meeting[tempId].numberOfMember++;
        member[_memberId].meeting.push(tempId);
        member[_memberId].numberOfMeeting++;
        MemberState memory tempState;
        tempState.stake = 0;
        tempState.state = 0;
        meeting[tempId].memberState[_memberId] = tempState;
        
        emit memberAddedInMeeting(_clubId, _meetingId, _memberId);
    }
}