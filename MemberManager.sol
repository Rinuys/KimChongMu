pragma solidity ^0.4.24;

import "./KimChongMu.sol";

contract MemberManager is KimChongMu{                  // 동아리 멤버를 관리하는 Contract
    event memberCreated(address _memberId);         // 멤버를 생성했을 때 호출되는 event
    
    function memberCreate() 
        public
    {                                                                       // 멤버를 만드는 함수
        require(!isMemberIdExist(msg.sender));
        Member memory temp;                                                 // temp 멤버를 생성
        temp.id = msg.sender;                                    // id를 변환 후 입력
        temp.numberOfClub = 0;
        member[msg.sender] = temp;
        memberIdArr.push(msg.sender);
        numberOfMember++;
        
        emit memberCreated(msg.sender);                             // event 호출
    }
    
    /*function memberDeleteByClubMaster(string _clubId, address _memberId) 
        public
    {                                                                       // member 삭제 함수
        require(isClubIdExist(_clubId));
        require(isMemberIdExist(_memberId));                       // memberId가 존재하는지 확인
        require(isMemberIdExist(msg.sender));
        require(club[_clubId].authority[_memberId] == 1);
        
        club[stringToId(_clubId)].numberOfMember--;                         // 멤버수 감소
    }*/
    
    /*function memberDeleteByMyself() 
        public
    {
        require(isMemberIdExist(msg.sender));
    }*/
    
    /*function transferToClub(string _memberId, string _clubId) 
        public 
        payable
    {                                                                       // 전체 계정에 회비 송금
        require(isMemberIdExist(_memberId, _clubId));
        require(
            club[stringToId(_clubId)].member[stringToId(_memberId)].account == msg.sender
        );                                                                  // 멤버에 저장된 account 주소가 
        uint value = msg.value;                                             // 함수를 호출한 주체와 같은지 비교
        clubBalance += value;                                               // 전체 balance에 돈을 송금
        club[stringToId(_clubId)].balance += value;                         // 동아리의 지분을 저장
        club[stringToId(_clubId)].member[stringToId(_memberId)].balance += value; // 멤버의 지분을 저장
        emit transferTo(_memberId, _clubId, value);
    }*/
    
    function getMemberInfo(address _memberId) 
        public 
        view 
        returns(address, uint32)
    {                                                                       // 멤버의 정보를 리턴 
        Member memory temp = member[_memberId];
        return(temp.id, temp.numberOfClub);    
    }
    
    /*function getMemberInfoByAddr(address memberAddr, string _clubId)
        external
        view
        returns(uint8, uint16, uint256, address)
    {
        bytes32 tempId;
        tempId = club[stringToId(_clubId)].memberAddrArr[memberAddr];
        Member memory temp = club[stringToId(_clubId)].member[tempId];
        return(temp.authority, temp.attendance, temp.balance, temp.account);
    }*/

    /*function revertBalance(string _memberId, string _clubId) 
        internal
    {                                                                       // 멤버들의 지분을 반환
        require(isMemberIdExist(_memberId, _clubId));
        require(club[stringToId(_clubId)].member[stringToId(_memberId)].authority == 1);
        clubBalance -= club[stringToId(_clubId)].balance;
        for(uint8 i = 0; i < club[stringToId(_clubId)].numberOfMember; i++) {
            club[stringToId(_clubId)].member[club[stringToId(_clubId)].memberIdArr[i]].account.transfer(
                club[stringToId(_clubId)].member[stringToId(_memberId)].balance);
        }
    }*/
}
