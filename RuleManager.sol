pragma solidity ^0.4.24;

import "./KimChongMu.sol";
import "./ClubManager.sol";
import "./MemberManager.sol";

contract RuleManager is MemberManager{
    event ruleCreated(uint8 ruleId, string _memberId, string _clubId);
    
    modifier idCheck(string _memberId, string _clubId){
        require(isMemberIdExist(_memberId, _clubId));
        require(club[stringToId(_clubId)].member[stringToId(_memberId)].account == msg.sender);
        require(club[stringToId(_clubId)].member[stringToId(_memberId)].authority == 1);
        _;
    }
    
    function ruleCreateType1(string _memberId, string _clubId, uint _time, uint256 _balance)
    public idCheck(_memberId, _clubId){   // 회비 납부 
        Rule memory temp;
        temp.ruleId = 1;
        temp.time = _time;
        temp.balance = _balance;
        club[stringToId(_clubId)].rule[1] = temp;
        emit ruleCreated(1, _memberId, _clubId);
    }
    
    function ruleCreateType2(string _memberId, string _clubId, uint _time, uint256 _balance, uint8 _numberOfLateness, uint8 _numberOfAbsence)
    public idCheck(_memberId, _clubId){
        Rule memory temp;
        temp.ruleId = 2;
        temp.time = _time;
        temp.balance = _balance;
        temp.numberOfLateness = _numberOfLateness;
        temp.numberOfAbsence = _numberOfAbsence;
        club[stringToId(_clubId)].rule[2] = temp;
        emit ruleCreated(2, _memberId, _clubId);
    }
    
    function setRuleTime(uint8 ruleId, string _memberId, string _clubId, uint _time)
    public idCheck(_memberId, _clubId){
        club[stringToId(_clubId)].rule[ruleId].time = _time;
    }
    
    function setRuleBalance(uint8 ruleId, string _memberId, string _clubId, uint256 _balance)
    public idCheck(_memberId, _clubId){
        club[stringToId(_clubId)].rule[ruleId].balance = _balance;
    }
    
    function setRuleNumberOfLateness(uint8 ruleId, string _memberId, string _clubId, uint8 _numberOfLateness)
    public idCheck(_memberId, _clubId){
        club[stringToId(_clubId)].rule[ruleId].numberOfLateness = _numberOfLateness;
    }
    
    function setRuleNumberOfAbsence(uint8 ruleId, string _memberId, string _clubId, uint8 _numberOfAbsence)
    public idCheck(_memberId, _clubId){
        club[stringToId(_clubId)].rule[ruleId].numberOfAbsence = _numberOfAbsence;
    }
    
    function getRule(uint8 _ruleId, string _memberId, string _clubId)
    public view returns(uint, uint, uint, uint, uint){
        require(isMemberIdExist(_memberId, _clubId));
        Rule memory temp;
        temp = club[stringToId(_clubId)].rule[_ruleId];
        return (temp.ruleId, temp.time, temp.balance, temp.numberOfLateness, temp.numberOfAbsence);
    }
    
}