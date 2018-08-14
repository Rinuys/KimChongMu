pragma solidity "0.4.24";
import "./MemberManager.sol";

contract ClubManager is MemberManager{ // 클럽 관리에 필요한 Contract
    event clubCreated(string _clubId, address _memberId);  // 클럽를 만들면 부르는 event
    event memberAddedInClub(string _clubId, address _memberId);
    event deletedMemberInClub(string _clubId, address _memberId);
    
    function clubCreate(string _clubId) 
        public
    {                               // 클럽을 생성하는 함수
        require(!isClubIdExist(_clubId));
        require(isMemberIdExist(msg.sender));
        Club memory temp;
        bytes32 tempId = stringToBytes32(_clubId);
        club[tempId] = temp;                    // 클럽 배열에 추가
        club[tempId].id = _clubId;              // id를 변환해서 입력
        club[tempId].member.push(msg.sender);   // msg.sender를 멤버에 추가
        club[tempId].numberOfMember = 1;        // 멤버수 증가
        //club[tempId].authority[msg.sender] = 1; // 해당 멤버의 권한을 1로 설정
        club[tempId].balance = 0;               // 클럽의 지분을 0으로 초기화
        club[tempId].numberOfMeeting = 0;       // 클럽의 모임수를 0으로 초기화

        member[msg.sender].club.push(_clubId);  // 멤버의 클럽배열에 추가
        member[msg.sender].numberOfClub++;      // 클럽수 증가
        
        clubIdArr.push(_clubId);    // clubIdArr에 추가 
        numberOfClub++;             // 클럽의 수를 증가
        
        emit clubCreated(_clubId, msg.sender);  // event 호출
    }
    
    function getClubBalance(string _clubId) 
        public 
        view 
        returns(uint)
    {                               // 클럽의 지분을 리턴
        require(isClubIdExist(_clubId));
        return club[stringToBytes32(_clubId)].balance;
    }
    
    function getClubInfo(string _clubId) 
        public                      // 클럽의 정보를 리턴
        view 
        returns(uint32, uint256, address[])
    {
        Club memory temp = club[stringToBytes32(_clubId)];
        return(temp.numberOfMember, temp.balance, temp.member);
    }
    
    function addMemberInClub(string _clubId, address _memberId, uint8 _authority) 
        public
    {                               // 클럽에 멤버를 추가
        bytes32 tempId = stringToBytes32(_clubId);
        require(isClubIdExist(_clubId));
        require(isMemberIdExist(_memberId));
//        require(club[tempId].authority[msg.sender] == 1);
        club[tempId].member.push(_memberId);
        club[tempId].numberOfMember++;
        club[tempId].authority[_memberId] = _authority;
        member[_memberId].club.push(_clubId);
        member[_memberId].numberOfClub++;
        
        emit memberAddedInClub(_clubId, _memberId);
    }

    function deleteMemberInClub(string _clubId, address _memberId)
        public                                      // 클럽에서 멤버를 삭제하는 함수
    {                                               // 해당 클럽내의 모임을 
        bytes32 tempId = stringToBytes32(_clubId);  // member가 참여하고 있지 않아야함
        require(isMemberInClub(_clubId, _memberId));
        require(isMemberInClub(_clubId, msg.sender));
        //require(club[tempId].authority[msg.sender] == 1 || _memberId == msg.sender);
        // _memberId가 자기 자신이거나 관리자일 경우만 삭제가능
        
        for(uint i = 0 ; i < club[tempId].numberOfMeeting ; i++){
            require(isMemberInMeeting_Bytes32(_memberId, club[tempId].meeting[i]) == false);
            // 클럽내의 모임에 참여하고 있지 않아야 삭제가능
        }

        uint check = 0;
        address[] storage tempMember = club[tempId].member;
        uint number = club[tempId].numberOfMember;
        for(uint j = 0 ; j < number ; j++){
            if(check == 1){
                tempMember[j-1] = tempMember[j];
            }
            if(tempMember[j] == _memberId){
                check++;
            }
            // 지울 멤버를 배열에서 찾으면 맨 뒤로 옮김
        }
        tempMember.length--;                // 배열의 크기를 줄임
        club[tempId].numberOfMember--;      // 클럽내의 멤버의 수를 줄임
        club[tempId].member = tempMember;   // 멤버 배열을 다시 달아줌

        emit deletedMemberInClub(_clubId, _memberId); // 멤버 삭제 이벤트
    }
}
