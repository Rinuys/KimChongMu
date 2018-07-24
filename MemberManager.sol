pragma solidity ^0.4.24;

import "./KimChongMu.sol";
import "./ClubManager.sol";

contract MemberManager is ClubManager{                  // 동아리 멤버를 관리하는 Contract
    event memberCreated(string _id, string _clubId);    // 멤버를 생성했을 때 호출되는 event
    
    function isMemberIdExist(string _memberId, string _clubId) internal view returns(bool){
        require(isClubIdExist(_clubId));
        bytes32 clubId = stringToId(_clubId);
        bytes32 memberId = stringToId(_memberId);
        uint i;
        for(i = 0 ; i < club[clubId].numberOfMember ; i++ ){
            if(club[clubId].memberIdArr[i] == memberId){
                break;
            }
        }
        return (i != club[clubId].numberOfMember);
    }
    
    function memberCreate(string _memberId, string _clubId, uint8 _authority) public{   // 멤버를 만드는 함수
        require(!isMemberIdExist(_memberId, _clubId));
        Member memory temp;                                                 // temp 멤버를 생성
        temp.id = stringToId(_memberId);                                    // id를 변환 후 입력
        temp.authority = _authority;                                        // 권한 부여
        temp.attendance = 0;                                                // 출석 초기화
        temp.account = msg.sender;                                          // account에 계좌 연결
        club[stringToId(_clubId)].member[stringToId(_memberId)] = temp;     // club에 member연결
        club[stringToId(_clubId)].numberOfMember++;                         // member 수를 증가시킴
        emit memberCreated(_memberId, _clubId);                             // event 호출
    }
    
    function memberDelete(string _memberId, string _clubId) public{         // member 삭제 함수
        require(isMemberIdExist(_memberId, _clubId));
        delete(club[stringToId(_clubId)].member[stringToId(_memberId)]);    // id로 참조하여 삭제
        club[stringToId(_clubId)].numberOfMember--;                         // 멤버수 감소
    } 
    
    function transferToClub(string _memberId, string _clubId) public payable{   // 전체 계정에 회비 송금
        require(isMemberIdExist(_memberId, _clubId));
        require(club[stringToId(_clubId)].member[stringToId(_memberId)].account == msg.sender); // 멤버에 저장된 account 주소가 
        uint value = msg.value;                                                                 // 함수를 호출한 주체와 같은지 비교
        clubBalance += value;                                               // 전체 balance에 돈을 송금
        club[stringToId(_clubId)].balance += value;                         // 동아리의 지분을 저장
        emit transferTo(_memberId, _clubId, value);
    }
    
    function getMemberBalance(string _memberId, string _clubId) public view returns(uint){      // 멤버의 지분을 리턴(아직 구현X)
        return club[stringToId(_clubId)].member[stringToId(_memberId)].balance;
    }
}