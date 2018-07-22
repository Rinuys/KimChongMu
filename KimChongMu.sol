pragma solidity ^0.4.24;

contract KimChongMu{
    struct Club{                                
        bytes32 id;
        uint32 numberOfMembers;
        mapping(bytes32 => Member) members;
        mapping(uint8 => Rule) rules;
        uint256 balance;
    }
    struct Member{
        bytes32 id;
        uint8 authority;
        uint16 attendance;
        address account;
        uint256 balance;
    }
    struct Rule{
        uint8 ruleId;
        bytes32 id;
        uint startTime;
        uint time;
        uint256 balance;
        bool late;
        uint8 numberOfLateness;
        bool absent;
        uint8 numberOfabsence;
    }
    
    mapping(bytes32 => Club) internal club;
    uint internal numberOfClub = 0;
    uint256 internal clubBalance = 0;
    
    function stringToId(string _id) internal pure returns(bytes32){
        return keccak256(bytes(_id));
    }
    
    function totalBalance() public view returns(uint){
        return clubBalance;
    }
    
}

contract ClubManager is KimChongMu{
    event ClubCreated(string _id);
    
    function clubCreate(string _id) public returns(bytes32){
        Club memory temp;
        temp.id = stringToId(_id);
        temp.numberOfMembers = 0;
        temp.balance = 0;
        club[temp.id] = temp;
        numberOfClub++;
        emit ClubCreated(_id);
        return club[temp.id].id;
    }
    
    
    function getClubBalance(string _clubId) public view returns(uint){
        return club[stringToId(_clubId)].balance;
    }
    
    /*function setRule1(string _memberId, string _clubId, uint _startTime, uint time){
        Rule memory temp;
        temp.ruleId = 1;
        
    }*/
}

contract MemberManager is KimChongMu{
    event MemberCreated(string _id, string _clubId);
    
    function memberCreate(string _memberId, string _clubId, uint8 _authority) public{
        Member memory temp;
        temp.id = stringToId(_memberId);
        temp.authority = _authority;
        temp.attendance = 0;
        temp.account = msg.sender;
        club[stringToId(_clubId)].members[stringToId(_memberId)] = temp;
        club[stringToId(_clubId)].numberOfMembers++;
        emit MemberCreated(_memberId, _clubId);
    }
    function memberDelete(string _memberId, string _clubId) public{
        delete(club[stringToId(_clubId)].members[stringToId(_memberId)]);
        club[stringToId(_clubId)].numberOfMembers--;
    }
    function transferToClub(string _memberId, string _clubId) public payable returns(string){
        require(club[stringToId(_clubId)].members[stringToId(_memberId)].account == msg.sender);
        uint value = msg.value;
        clubBalance+=value;
        club[stringToId(_clubId)].balance += value;
    }
    function getMemberBalance(string _memberId, string _clubId) public view returns(uint){
        return club[stringToId(_clubId)].members[stringToId(_memberId)].balance;
    }
}

contract RuleManager is MemberManager{
    
}