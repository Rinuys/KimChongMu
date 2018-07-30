pragma solidity ^0.4.24;

contract KimChongMu{                // KimChongMu contract
    struct Club{                    // 동아리 구조체
        bytes32 id;                 // 동아리의 id(바이트32)
        uint32 numberOfMember;      // 동아리 멤버의 수
        mapping(bytes32 => Member) member;  // 멤버들을 저장할 매핑변수
        bytes32[] memberIdArr;              // 멤버들의 id를 저장할 배열
        mapping(uint8 => Rule) rule;        // 회칙들을 저장할 매핑변수
        uint256 balance;            // 동아리의 회비
    }
    struct Member{                  // 멤버의 구조체
        bytes32 id;                 // 멤버의 id(바이트32)
        uint8 authority;            // 멤버의 권한(1:master, 2...)
        uint16 attendance;          // 멤버의 출석수 결석수 기타등등
        address account;            // 멤버의 지갑계정
        uint256 balance;            // 멤버의 지분
    }
    struct Rule{                    // 회칙을 저장할 구조체
        uint8 ruleId;               // 회칙의 id (1:회비, 2:출결)
        uint time;                  // 1:주기   /2:모임시간
        uint256 balance;            // 1:회비   /2:벌금
        uint8 numberOfLateness;     // 1:X      /2:지각수
        uint8 numberOfAbsence;      // 1:X      /2:결석수
    }
    
    mapping(bytes32 => Club) public club;   // club들을 저장하는 매핑변수
    bytes32[] internal clubIdArr;           // club들의 id를 저장하는 배열
    uint internal numberOfClub = 0;         // 동아리의 수
    uint256 internal clubBalance = 0;       // 전체 동아리의 계좌(CA)
    uint8 internal numberOfRule = 2;        // 사용 가능한 회칙의 개수 
    
    event transferTo(string _from, string _to, uint256 _value);     // 송금할 경우 이벤트 호출 
    
    function stringToId(string _id) 
        internal 
        pure 
        returns(bytes32)
    {                                       // string형식의 id를
        return keccak256(bytes(_id));       // byte32형식으로 변환
    }                                       // (keccak256)
    
    function totalBalance() 
        public 
        view 
        returns(uint)
    {                                       // 전체 balance를 출력
        return clubBalance;
    }
    
}