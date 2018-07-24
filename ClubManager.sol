pragma solidity ^0.4.24;
import "./KimChongMu.sol";

contract ClubManager is KimChongMu{ // 동아리 관리에 필요한 Contract
    event ClubCreated(string _clubId);  // 동아리를 만들면 부르는 event
    
    function clubCreate(string _clubId) public returns(bool){       // club을 생성하는 함수
        require(!isClubIdExist(_clubId));
        Club memory temp;           // temp에 저장하고 배열에 추가하는 방식
        temp.id = stringToId(_clubId);  // id를 변환해서 입력
        temp.numberOfMember = 0;    // 멤버의 수를 초기화
        temp.balance = 0;           // 동아리의 지분을 0으로 초기화
        club[temp.id] = temp;       // club배열에 추가
        clubIdArr.push(temp.id);    // clubId배열에 추가 
        numberOfClub++;             // 동아리의 수를 증가
        emit ClubCreated(_clubId);  // event 호출
        return true;                // id를 리턴
    }
    
    function isClubIdExist(string _clubId) internal view returns(bool){
        bytes32 clubId = stringToId(_clubId);
        uint i;
        for(i = 0 ; i < numberOfClub ; i++ ){
            if(clubIdArr[i] == clubId){
                break;
            }
        }
        return (i != numberOfClub);
    }
    
    
    function getClubBalance(string _clubId) public view returns(uint){  // 동아리의 지분을 리턴
        require(isClubIdExist(_clubId));
        return club[stringToId(_clubId)].balance;
    }
    
}