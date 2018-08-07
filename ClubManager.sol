pragma solidity ^0.4.24;
import "./MemberManager.sol";

contract ClubManager is MemberManager{ // 동아리 관리에 필요한 Contract
    event ClubCreated(string _clubId, address _memberId);  // 동아리를 만들면 부르는 event
    event AddMember(string _clubId, address _memberId);
    
    function clubCreate(string _clubId) 
        public
    {                               // club을 생성하는 함수
        require(!isClubIdExist(_clubId));
        require(isMemberIdExist(msg.sender));
        Club memory temp;
        bytes32 tempId = stringToBytes32(_clubId);
        club[tempId] = temp;                // club배열에 추가
        club[tempId].id = _clubId;          // id를 변환해서 입력
        club[tempId].member.push(msg.sender);
        club[tempId].numberOfMember = 1;    // 
        club[tempId].authority[msg.sender] = 1;
        club[tempId].balance = 0;           // 동아리의 지분을 0으로 초기화
        member[msg.sender].club.push(_clubId);
        member[msg.sender].numberOfClub++;
        
        clubIdArr.push(_clubId);    // clubId배열에 추가 
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
    
    function addMember(string _clubId, address _memberId, uint8 _authority) 
        public
    {
        bytes32 tempId = stringToBytes32(_clubId);
        require(isClubIdExist(_clubId));
        require(isMemberIdExist(_memberId));
        require(club[tempId].authority[msg.sender] == 1);
        club[tempId].member.push(_memberId);
        club[tempId].numberOfMember++;
        club[tempId].authority[_memberId] = _authority;
        member[_memberId].club.push(_clubId);
        member[_memberId].numberOfClub++;
        
        emit AddMember(_clubId, _memberId);
    }
}