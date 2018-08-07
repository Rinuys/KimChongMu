pragma solidity ^0.4.24;

contract KimChongMu{                // KimChongMu contract
    struct Club{                    // 동아리 구조체
        string id;                  // 동아리의 id
        address[] member;
        mapping(address => uint8) authority;
        uint32 numberOfMember;      // 동아리 멤버의 수
        mapping(uint8 => Meeting) meeting;
        uint8 numberOfMeeting;
        uint256 balance;            // 동아리의 회비
    }
    struct Member{                  // 멤버의 구조체
        address id;                 // 멤버의 id(바이트32)
        string[] club;
        uint32 numberOfClub;        // club
    }
    struct Meeting{
        uint256 time;
        uint256 balance;
        mapping(address => MemberState) memberState;
    }
    struct MemberState{
        uint256 stake;
        uint8 state;
    }
    
    struct Rule{                    // 회칙을 저장할 구조체
        uint8 ruleId;               // 회칙의 id (1:회비, 2:출결)
        uint8 numberOfLateness;     // 1:X      /2:지각수
        uint8 numberOfAbsence;      // 1:X      /2:결석수
        uint256 balance;            // 1:회비   /2:벌금
        uint time;                  // 1:주기   /2:모임시간
    }
    
    mapping(bytes32 => Club) public club;   // club들을 저장하는 매핑변수
    string[] internal clubIdArr;           // club들의 id를 저장하는 배열
    uint256 internal numberOfClub = 0;     // 동아리의 수
    
    mapping(address => Member) public member;
    address[] internal memberIdArr;
    uint256 internal numberOfMember = 0;
    
    uint8 internal numberOfRule = 2;        // 사용 가능한 회칙의 개수 
    
    event transferTo(string _from, string _to, uint256 _value);     // 송금할 경우 이벤트 호출 
    
    function stringToBytes32(string _id) 
        internal 
        pure 
        returns(bytes32)
    {                                       // string형식의 id를
        return keccak256(bytes(_id));       // byte32형식으로 변환
    }                                       // (keccak256)
    
    function getContractBalance() 
        public 
        view 
        returns(uint)
    {                                       // 전체 balance를 출력
        return this.balance;
    }
    
    function isMemberIdExist(address _memberId)              // 멤버의 아이디가 있는지 체크하는 함수
        internal 
        view 
        returns(bool)
    {
        uint i;
        for(i = 0 ; i < numberOfMember ; i++){                 // .memberIdArr에 memberId가 있는지 체크
            if(memberIdArr[i] == _memberId){
                break;
            }
        }
        return (i != numberOfMember && numberOfMember != 0);                          // 있으면 true, 없으면 false
    }
    
    function isClubIdExist(string _clubId) 
        public 
        view 
        returns(bool)
    {                               // 동아리 id가 존재하는지 검사하는 함수
        uint i;
        for(i = 0 ; i < numberOfClub ; i++ ){
            if(keccak256(clubIdArr[i]) == keccak256(_clubId)){ // clubIdArr에 id가 존재하는지 검사
                break;
            }
        }
        return (i != numberOfClub && numberOfClub != 0); // 존재하면 true, 없으면 false
    }
    
    function getNumberOfClub() 
        public 
        view 
        returns(uint256)
    {
        return numberOfClub;
    }
    
    function getNumberOfMember()
        public
        view
        returns(uint256)
    {
        return numberOfMember;
    }
    
    
}