pragma solidity "0.4.24";

import "./ClubManager.sol";

contract MeetingManager is ClubManager{
    event meetingCreated(string _clubId, string _meetingId);
    event memberAddedInMeeting(string _clubId, string _meetingId, address _memberId);
    
    function meetingCreate(                     // 모임 생성 함수
        string _clubId,               
        string _meetingId,                      // _meetingId : 모임이름
        uint256 _time,                          // _time : 모임시간
        uint256 _value                          // _value : 예치해야하는 금액
    )                                           
        public 
    {
        require(isClubIdExist(_clubId));
        require(isMemberIdExist(msg.sender));
        require(!isMeetingIdExist(_clubId, _meetingId, _time));
        require(club[stringToBytes32(_clubId)].authority[msg.sender] == 1);
        Meeting memory temp;
        temp.id = _meetingId;
        temp.time = _time;
        temp.value = _value;
        temp.clubId = _clubId;
        temp.state = 0;
        temp.totalBalance = 0;

        bytes32 tempId = argToBytes32(_clubId, _meetingId, _time);
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
    
    function addMemberInMeeting(
        string _clubId,
        string _meetingId,
        uint256 _time,
        address _memberId
    ) 
        public
    {
        require(isClubIdExist(_clubId));
        require(isMemberIdExist(msg.sender));
        bytes32 tempId = argToBytes32(_clubId, _meetingId, _time);
        require(isMeetingIdExist(_clubId, _meetingId, _time));
        require(meeting[tempId].state == 0);
        require(club[stringToBytes32(_clubId)].authority[msg.sender] == 1);
        
        
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

    function startTransfer(string _clubId, string _meetingId, uint256 _time)
        public
    {
        require(isClubIdExist(_clubId));
        require(isMeetingIdExist(_clubId, _meetingId, _time));
        require(isMemberInMeeting(_clubId, _meetingId, _time, msg.sender));
        require(club[stringToBytes32(_clubId)].authority[msg.sender] == 1);
        bytes32 tempId = argToBytes32(_clubId, _meetingId, _time);
        require(meeting[tempId].state == 0);

        meeting[tempId].state = 1;
    }
    
    function transferToMeeting(string _clubId, string _meetingId, uint256 _time) 
        public 
        payable
    {
        require(isClubIdExist(_clubId));
        require(isMeetingIdExist(_clubId, _meetingId, _time));
        bytes32 tempId = argToBytes32(_clubId, _meetingId, _time);
        require(isMemberInMeeting_Bytes32(msg.sender, tempId));
        require(meeting[tempId].state == 1);
        require(msg.value >= meeting[tempId].value);
        
        meeting[tempId].totalBalance += msg.value;
        meeting[tempId].memberState[msg.sender].stake = msg.value;
        
        club[stringToBytes32(_clubId)].balance += msg.value;
        
        emit transferTo(msg.sender, address(this), msg.value);

        if(checkMeetingBalance(tempId) == true){
            meeting[tempId].state = 2;
        }
    }
    
    function isMemberInMeeting(
        string _clubId,
        string _meetingId,
        uint256 _time, 
        address _memberId
    ) 
        public 
        view
        returns(bool)
    {
        bytes32 tempId = argToBytes32(_clubId, _meetingId, _time);
        uint tempNumber = meeting[tempId].numberOfMember;
        uint i;
        for(i = 0 ; i < tempNumber ; i++){
            if(meeting[tempId].member[i] == _memberId){
                break;
            }
        }
        return (i != tempNumber && tempNumber != 0);
    }

    function checkMeetingBalance(bytes32 _meetingId) 
        internal 
        view
        returns(bool)
    {
        uint check=0;
        address[] memory member = meeting[_meetingId].member;
        for(uint i = 0 ; i < meeting[_meetingId].numberOfMember ; i++){
            if(meeting[_meetingId].memberState[member[i]].stake >= meeting[_meetingId].value){
                check++;
            }
        }
        if(check == meeting[_meetingId].numberOfMember){
            return true;
        }
        else{
            return false;
        }
    }
    
    function getMeetingInfo(string _clubId, string _meetingId, uint256 time)
        public
        view
        returns(string, uint256, uint256, uint8, uint32)
    {
        bytes32 tempId = argToBytes32(_clubId, _meetingId, time);
        Meeting memory temp = meeting[tempId];
        return(temp.id, temp.value, temp.totalBalance, temp.state, temp.numberOfMember);
    }
    
/*
    function revertBalance(string _clubId, bytes32 _meetingId) 
        internal
    {                                                                       // 멤버들의 지분을 반환
        require(isMemberIdExist(_memberId, _clubId));
        require(club[stringToId(_clubId)].member[stringToId(_memberId)].authority == 1);
        clubBalance -= club[stringToId(_clubId)].balance;
        for(uint8 i = 0; i < club[stringToId(_clubId)].numberOfMember; i++) {
            club[stringToId(_clubId)].member[club[stringToId(_clubId)].memberIdArr[i]].account.transfer(
                club[stringToId(_clubId)].member[stringToId(_memberId)].balance);
        }
    }

    function deleteMeeting(string _clubId, string _meetingId, uint256 time){

    }*/
}