pragma solidity ^0.4.24;

import "./MemberManager.sol";

contract ClubManager is MemberManager{ // 동아리 관리에 필요한 Contract
    event ClubCreated(string _clubId, address _memberId);  // 동아리를 만들면 부르는 event
    event AddMember(string _clubId, address _memberId);
    
    function clubCreate(string _clubId) 
        public 
    {                               // club을 생성하는 함수
        require(!isClubIdExist(_clubId));
        require(!isMemberIdExist(msg.sender));
        Club storage temp;           // temp에 저장하고 배열에 추가하는 방식
        temp.id = _clubId;          // id를 변환해서 입력
        temp.numberOfMember = 1;    // 
        temp.member.push(msg.sender);
        temp.authority[msg.sender] = 1;
        member[msg.sender].club.push(_clubId);
        member[msg.sender].numberOfClub++;
        temp.balance = 0;           // 동아리의 지분을 0으로 초기화
        club[stringToBytes32(temp.id)] = temp;       // club배열에 추가
        clubIdArr.push(temp.id);    // clubId배열에 추가 
        numberOfClub++;             // 동아리의 수를 증가
        
        emit ClubCreated(_clubId, msg.sender);  // event 호출
    }
    
    function getClubBalance(string _clubId) 
        public 
        view 
        returns(uint)
    {                               // 동아리의 지분을 리턴
        require(isClubIdExist(_clubId));
        return club[stringToBytes32(_clubId)].balance;
    }
    
    function getClubInfo(string _clubId) 
        public 
        view 
        returns(uint32, uint256, address[])
    {
        Club memory temp = club[stringToBytes32(_clubId)];
        return(temp.numberOfMember, temp.balance, temp.member);
    }
    
    function addMember(string _clubId, address _memberId, uint8 _authority) public{
        require(isClubIdExist(_clubId));
        require(isMemberIdExist(_memberId));
        require(club[stringToBytes32(_clubId)].authority[msg.sender] == 1);
        club[stringToBytes32(_clubId)].member.push(_memberId);
        club[stringToBytes32(_clubId)].numberOfMember++;
        club[stringToBytes32(_clubId)].authority[_memberId] = _authority;
        member[_memberId].club.push(_clubId);
        member[_memberId].numberOfClub++;
        
        emit AddMember(_clubId, _memberId);
    }
}