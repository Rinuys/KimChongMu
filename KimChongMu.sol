pragma solidity ^0.4.24;

contract KimChongMu{                // KimChongMu contract
    struct Club{                    // 동아리 구조체
        bytes32 id;                 // 동아리의 id(바이트32)
        uint32 numberOfMembers;     // 동아리 멤버의 수
        mapping(bytes32 => Member) members; // 멤버들을 저장할 매핑변수
        mapping(uint8 => Rule) rules;       // 회칙들을 저장할 매핑변수
        uint256 balance;            // 동아리의 회비
    }
    struct Member{                  // 멤버의 구조체
        bytes32 id;                 // 멤버의 id(바이트32)
        uint8 authority;            // 멤버의 권한(1:master, 2...)
        uint16 attendance;          // 멤버의 출석수
        address account;            // 멤버의 지갑계정
        uint256 balance;            // 멤버의 지분
    }
    struct Rule{                    // 회칙을 저장할 구조체
        uint8 ruleId;               // 회칙의 id
        bytes32 id;                 // 대상의 id
        uint startTime;             // 모임 시간 (ruleId=2 일때 사용)
        uint time;                  // 출석 시간 (ruleId=2 일때 사용)
        uint256 balance;            // 회비
        bool late;                  // 지각여부
        uint8 numberOfLateness;     // 지각횟수
        bool absent;                // 결석여부
        uint8 numberOfabsence;      // 결석횟수
    }
    
    mapping(bytes32 => Club) internal club; // club들을 저장하는 매핑변수
    uint internal numberOfClub = 0;         // 동아리의 수
    uint256 internal clubBalance = 0;       // 전체 동아리의 계좌(CA)
    
    function stringToId(string _id) internal pure returns(bytes32){ // string형식의 id를
        return keccak256(bytes(_id));                               // byte32형식으로 변환
    }                                                               // keccak256
    
    function totalBalance() public view returns(uint){              // 전체 balance를 출력
        return clubBalance;
    }
    
}

contract ClubManager is KimChongMu{ // 동아리 관리에 필요한 Contract
    event ClubCreated(string _id);  // 동아리를 만들면 부르는 event
    
    function clubCreate(string _id) public returns(bool){                // club을 생성하는 함수
        Club memory temp;           // temp에 저장하고 배열에 추가하는 방식
        temp.id = stringToId(_id);  // id를 변환해서 입력
        temp.numberOfMembers = 0;   // 멤버의 수를 초기화
        temp.balance = 0;           // 동아리의 지분을 0으로 초기화
        club[temp.id] = temp;       // club배열에 추가
        numberOfClub++;             // 동아리의 수를 증가
        emit ClubCreated(_id);      // event 호출
        return true;                // id를 리턴
    }
    
    
    function getClubBalance(string _clubId) public view returns(uint){  // 동아리의 지분을 리턴
        return club[stringToId(_clubId)].balance;
    }
    
    /*function setRule1(string _memberId, string _clubId, uint _startTime, uint time){
        Rule memory temp;
        temp.ruleId = 1;
        
    }*/
}

contract MemberManager is KimChongMu{       // 동아리 멤버를 관리하는 Contract
    event MemberCreated(string _id, string _clubId);    // 멤버를 생성했을 때 호출되는 event
    
    function memberCreate(string _memberId, string _clubId, uint8 _authority) public{   // 멤버를 만드는 함수
        Member memory temp;                                                 // temp 멤버를 생성
        temp.id = stringToId(_memberId);                                    // id를 변환 후 입력
        temp.authority = _authority;                                        // 권한 부여
        temp.attendance = 0;                                                // 출석 초기화
        temp.account = msg.sender;                                          // account에 계좌 연결
        club[stringToId(_clubId)].members[stringToId(_memberId)] = temp;    // club에 member연결
        club[stringToId(_clubId)].numberOfMembers++;                        // member 수를 증가시킴
        emit MemberCreated(_memberId, _clubId);                             // event 호출
    }
    function memberDelete(string _memberId, string _clubId) public{         // member 삭제 함수
        delete(club[stringToId(_clubId)].members[stringToId(_memberId)]);   // id로 참조하여 삭제
        club[stringToId(_clubId)].numberOfMembers--;                        // 멤버수 감소
    }
    function transferToClub(string _memberId, string _clubId) public payable returns(string){   // 전체 계정에 회비 송금
        require(club[stringToId(_clubId)].members[stringToId(_memberId)].account == msg.sender);// 멤버에 저장된 account 주소가 
        uint value = msg.value;                                                                 // 함수를 호출한 주체와 같은지 비교
        clubBalance += value;                                               // 전체 balance에 돈을 송금
        club[stringToId(_clubId)].balance += value;                         // 동아리의 지분을 저장
    }
    function getMemberBalance(string _memberId, string _clubId) public view returns(uint){      // 멤버의 지분을 리턴(아직 구현X)
        return club[stringToId(_clubId)].members[stringToId(_memberId)].balance;
    }
}

contract RuleManager is MemberManager{
    
}