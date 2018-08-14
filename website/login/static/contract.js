var kimchongmuAddress = "0xc3ef363588d77a0bb7e06609afc37e1f113bedf0";

function startApp(){

  window.addEventListener('load', function() {

    // Web3가 브라우저에 주입되었는지 확인(Mist/MetaMask)
    if (typeof web3 !== 'undefined') {//!=
      // Mist/MetaMask의 프로바이더 사용
      web3 = new Web3(web3.currentProvider);
    } else {
      // 사용자가 Metamask를 설치하지 않은 경우에 대해 처리
      // 사용자들에게 Metamask를 설치하라는 등의 메세지를 보여줄 것
    }
  });
  var myContract = web3.eth.contract(kimchongmuABI);
  window.contractInstance = web3.eth.contract(kimchongmuABI).at(kimchongmuAddress);

  web3.eth.getAccounts(function(error, result){
            if (error) return console.error(error);
             window.web3.eth.defaultAccount = result[0];
           });
  var accountInterval = setInterval(function() {
  // 계정이 바뀌었는지 확인

  web3.eth.getAccounts(function(error, result){
            if (error) return console.error(error);
            if (window.web3.eth.defaultAccount !== result[0]) {
              window.web3.eth.defaultAccount = result[0];
            }
           });
}, 100);
}
//culbCreate(clubId);
//memberCreate();//본인의 주소가 멤버아이디로 사용되기 때문에 매개변수 필요x
//getClubInfo(clubId);
console.log(window.contractInstance);
getMemberInfo();

//클럽 생성 함수
function clubCreate(_clubId){
web3.eth.getAccounts(function(error, result){//set함수는 getaccount필요? & function으로 뒤에 출력하는거 써줘야한다
  if (error) return console.error(error);
  else window.contractInstance.clubCreate(_clubId, function(error, result){
    if(!error)
      console.log(JSON.stringify(result));
    else
      console.error(error);
  });
});
}

//멤버 생성 함수
function memberCreate(){
web3.eth.getAccounts(function(error, result){
  if (error) return console.error(error);
  else window.contractInstance.memberCreate(function(error, result){
    if (error) return console.error(error);
    else console.log(JSON.stringify(result));
  });
});
}

//클럽 정보 불러오기 함수
function getClubInfo(_clubId){
window.contractInstance.getClubInfo(_clubId, function(error, result){
  if (error) return console.error(error);
  else console.log(JSON.stringify(result));//get은 보여주는함수 보여줘야만한다
});
}

function getClubInfo(_clubId){
window.contractInstance.club(_clubId, function(error, result){
  if (error) return console.error(error);
  else console.log(JSON.stringify(result));
});
}

function getMember(){
  web3.eth.getAccounts(function(error, result){
    if (error) return console.error(error);
    else window.contractInstance.member(result[0], function(error, result){
      if (error) return console.error(error);
      else console.log(JSON.stringify(result));
    });
  });
}

function getMemberInfo(){
  web3.eth.getAccounts(function(error, result){
    if (error) return console.error(error);
    else window.contractInstance.getMemberInfo(function(error, result){
      if (error) return console.error(error);
      else console.log(JSON.stringify(result));
    });
  });
}

startApp();
