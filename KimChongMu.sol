pragma solidity "0.4.24";

contract KimChongMu{                // KimChongMu contract
    struct Club{                    // 클럽 구조체
        string id;                  // 클럽의 id(string)
        address[] member;           // 클럽에 가입된 멤버
        mapping(address => uint8) authority; // 각 멤버의 authority를 저장
        uint32 numberOfMember;      // 클럽 멤버의 수
        bytes32[] meeting;          // 클럽에 등록된 모임
        uint8 numberOfMeeting;      // 모임의 수
        uint256 balance;            // 클럽의 총 지분
    }
    struct Member{                  // 멤버의 구조체
        address id;                 // 멤버의 id(주소)
        string[] club;              // 멤버가 포함된 클럽
        uint32 numberOfClub;        // 클럽의 수
        bytes32[] meeting;          // 멤버가 진행중인 모임
        uint8 numberOfMeeting;      // 모임의 수
    }
    struct Meeting{                 // 모임의 구조체(식별자:keccak256(id+clubId+time))
        string id;                  // 모임의 id(string)
        string clubId;              // 모임이 소속된 클럽의 id
        uint256 time;               // 모임시간
        uint256 value;              // 예치해야하는 금액
        uint256 totalBalance;       // 모임의 지분
        uint8 state;                // 모임의 상태
                                    // 0:모임생성, 1:예치금받기, 2:모임유효, 3:모임끝
                                    // state=0까지 멤버추가가능(1부터 추가불가)
        mapping(address => MemberState) memberState; // 각 멤버들의 상태
        address[] member;           // 모임에 포함된 멤버
        uint32 numberOfMember;      // 멤버의 수
    }
    struct MemberState{             // 멤버의 상태 구조체(모임)
        uint256 stake;              // 멤버의 지분
        uint8 state;                // 멤버의 상태
    }
    
    mapping(bytes32 => Club) public club;       // 클럽(전역)
    string[] internal clubIdArr;                // 클럽들의 id를 저장
    uint256 internal numberOfClub = 0;          // 클럽의 수
    
    mapping(address => Member) public member;   // 멤버(전역)
    address[] internal memberIdArr;             // 멤버들의 id를 저장
    uint256 internal numberOfMember = 0;        // 멤버의 수
    
    mapping(bytes32 => Meeting) public meeting; // 모임(전역)
    bytes32[] internal meetingIdArr;            // 모임의 id를 저장
    uint256 internal numberOfMeeting;           // 모임의 수
    
    event transferTo(address _from, address _to, uint256 _value); // 송금할 경우 이벤트 호출 
    
    function stringToBytes32(string _id) 
        internal 
        pure 
        returns(bytes32)
    {                                       // string형식의 id를
        return keccak256(bytes(_id));       // byte32형식으로 변환
    }                                       // (keccak256)

    function argToBytes32(string _clubId, string _meetingId, uint256 _time)
        internal
        pure
        returns(bytes32)
    {
        return keccak256(abi.encodePacked(_clubId, _meetingId, _time));
    }
    
    function getContractBalance() 
        public 
        view 
        returns(uint)
    {                                       // 전체 CA의 balance를 반환
        return address(this).balance;
    }
    
    function isMemberIdExist(address _memberId)         // 멤버의 아이디가 있는지 체크하는 함수
        internal 
        view 
        returns(bool)
    {
        uint i;
        for(i = 0 ; i < numberOfMember ; i++){          // memberIdArr에 memberId가 있는지 체크
            if(memberIdArr[i] == _memberId){
                break;
            }
        }
        return (i != numberOfMember && numberOfMember != 0); // 있으면 true, 없으면 false
    }
    
    function isClubIdExist(string _clubId) 
        public 
        view 
        returns(bool)
    {                                       // 클럽 id가 존재하는지 검사하는 함수
        uint i;
        for(i = 0 ; i < numberOfClub ; i++ ){
            if(keccak256(abi.encodePacked(clubIdArr[i])) == 
                keccak256(abi.encodePacked(_clubId))){ // clubIdArr에 id가 존재하는지 검사
                break;
            }
        }
        return (i != numberOfClub && numberOfClub != 0); // 존재하면 true, 없으면 false
    }
    
    function isMeetingIdExist(string _clubId, string _meetingId, uint256 _time)
        public                              // 모임 id가 존재하는지 검사하는 함수
        view
        returns(bool)
    {
        bytes32 tempId = keccak256(
            abi.encodePacked(_clubId, _meetingId, _time)
        );
        uint i;
        for(i = 0 ; i < numberOfMeeting ; i++){
            if(meetingIdArr[i] == tempId){
                break;
            }
        }
        return (i != numberOfMeeting && numberOfMeeting != 0);  // 존재하면 true, 없으면 false
    }

    function isMeetingIdExist_Bytes32(bytes32 _meetingId)
        public                              // 모임 id가 존재하는지 검사하는 함수
        view
        returns(bool)
    {
        uint i;
        for(i = 0 ; i < numberOfMeeting ; i++){
            if(meetingIdArr[i] == _meetingId){
                break;
            }
        }
        return (i != numberOfMeeting && numberOfMeeting != 0);  // 존재하면 true, 없으면 false
    }

    function isMemberInClub(string _clubId, address _memberId)
        public
        view
        returns(bool)
    {
        require(isClubIdExist(_clubId));
        require(isMemberIdExist(_memberId));
        bytes32 clubId = stringToBytes32(_clubId);
        uint number = club[clubId].numberOfMember;
        uint i;
        for(i = 0 ; i < number ; i++){
            if(club[clubId].member[i] == _memberId){
                break;
            }
        }
        return (i != number && number != 0); // 있으면 true, 없으면 false
    }

    function isMemberInMeeting(string _clubId, string _meetingId, uint256 _time, address _memberId)
        public
        view
        returns(bool)
    {
        require(isMemberIdExist(_memberId));
        require(isMeetingIdExist(_clubId, _meetingId, _time));
        bytes32 meetingId = argToBytes32(_clubId, _meetingId, _time);
        uint number = meeting[meetingId].numberOfMember;
        uint i;
        for(i = 0 ; i < number ; i++){
            if(meeting[meetingId].member[i] == _memberId){
                break;
            }
        }
        return (i != number && number != 0); // 있으면 true, 없으면 false
    }

    function isMemberInMeeting_Bytes32(address _memberId, bytes32 _meetingId)
        public
        view
        returns(bool)
    {
        require(isMemberIdExist(_memberId));
        require(isMeetingIdExist_Bytes32(_meetingId));
        uint number = meeting[_meetingId].numberOfMember;
        uint i;
        for(i = 0 ; i < number ; i++){
            if(meeting[_meetingId].member[i] == _memberId){
                break;
            }
        }
        return (i != number && number != 0); // 있으면 true, 없으면 false
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
    
    function getNumberOfMeeting()
        public
        view
        returns(uint256)
    {
        return numberOfMeeting;
    }
    
}