var kimchongmuAddress = "0x4591e6485f07eef4f36eff8fe4ad1877383b6779";
var myContract;
var myAddress;
var firstCall;

// 화면이 load되면 metaMask 체크
window.addEventListener('load', function () {
  if (typeof web3 !== 'undefined') {
    web3 = new Web3(web3.currentProvider);
    startApp(); // 메타마스크 존재하면 초기화작업 수행
  } else {
    console.log("메타마스크를 설치해 주세요.");
  }
});


// 초기화 함수
function startApp() {
  
  myContract = web3.eth.contract(kimchongmuABI).at(kimchongmuAddress);
  firstCall = true;
  web3.eth.getAccounts(function (error, accounts) {
    if (error) { 
      return console.error(error)
    }
    else if(accounts.length == 0){
      console.log("Error : User is not logged in to MetaMask");
    }
    else{
      myAddress = accounts[0];
      window.web3.eth.defaultAccount = accounts[0];
    }
  });

  var accountInterval = setInterval(function () {
    // 계정이 바뀌었는지 확인
    web3.eth.getAccounts(function (error, result) {
      if (error) return console.error(error);
      if (window.web3.eth.defaultAccount !== result[0]) {
        window.web3.eth.defaultAccount = result[0];
      }
    });
  }, 100);
}



// metaMast 로그인 여부 체크
$('#checkMetamask').click(function () {

  if(web3.eth.accounts.length == 0){
    alert("메타마스크 로그인이 필요합니다.");
    return false;
  }else{
    var url = $("#checkMetamask").attr("href");
    location.href = url;  
  }
});



// 회원 가입 시 멤버 생성
$("#memberCreate").submit(function () {
  if (firstCall) {
    myContract.memberCreate.sendTransaction({ from: myAddress }, 
      function (err, transactionHash) {
        if (!err) {
          console.log(transactionHash + " success");
          firstCall = false;
          $("#memberCreate").submit();
        }
      }
    );
    return false;

  } else {
    return true;
  }
});



// 클럽 생성 루틴
$("#clubCreate").submit(function () {
  if (firstCall) {
    var clubName = document.getElementById("clubName").value;

    // 존재하는 클럽명인지 체크
    myContract.isClubIdExist.call(clubName, 
      function (err, result) {
        if (err) 
          return console.error(err);
        if(result == true){
          console.log(clubName);
          alert("이미 존재하는 클럽명입니다. 다른 클럽명을 입력해주세요.");
        }else{
          // 클럽 생성
          console.log(result);
          createClub(clubName);
        }
      }
    );
    return false;

  } else {
    return true;
  }
});
  
function createClub(clubName){
  // 클럽 생성
  myContract.clubCreate.sendTransaction(clubName, { from: myAddress }, 
    function (err, transactionHash) {
      if (!err) {
        console.log(transactionHash + " success");
        alert("클럽 생성이 완료될때까지 잠시만 기다려주십시오. (30초 ~ 1분 소요)");
        var receipt = null;

        // 블록 생성시마다 반복
        var filter = web3.eth.filter("latest");
        filter.watch(function(error, result){
          alert("클럽 생성 진행중입니다. 잠시만 기다려주세요!");

          // transaction 컨펌났는지 확인
          web3.eth.getTransactionReceipt(transactionHash, function (err, result) {
            receipt = result;
            console.log(receipt);
            if(receipt != null){
              filter.stopWatching();
              alert("클럽 생성이 완료되었습니다! 회원님의 멤버추가 절차를 시작하겠습니다.");

              // 클럽장 멤버로 추가
              var memberID = myAddress;
              var authority = 1;
              myContract.addMemberInClub.sendTransaction(clubName, memberID, authority, { from: myAddress },
                function (err, transactionHash) {
                  if (!err) {
                    console.log(transactionHash + " success");
                    firstCall = false;
                    $("#clubCreate").submit();
                  }
                }
              );
            }
          });
        });
      }
    }
  );
}



// 클럽에 멤버 추가 루틴
$("#addMember").submit(function () {
  if(firstCall){

      var clubID = document.getElementById("clubName").value;
      var memberID = myAddress;
      var authority = 2;

      var clubMembers = $("#clubMembers").val();
      console.log(clubMembers);



      myContract.addMember.sendTransaction(clubID, memberID, authority, { from: myAddress }, function (err, transactionHash) {
          if (!err){
            console.log(transactionHash + " success");
            firstCall= false;
            $("#addMember").submit();
          }
        }
      );
      return false;
  }else{
    return true;
  }
});




















//클럽 정보 불러오기 함수
function getClubInfo(_clubId){
myContract.getClubInfo(_clubId, function(error, result){
  if (error) return console.error(error);
  else console.log(JSON.stringify(result));//get은 보여주는함수 보여줘야만한다
});
}


function getMemberInfo(){
  web3.eth.getAccounts(function(error, result){
    if (error) return console.error(error);
    else myContract.member(result[0], function(error, result){
      if (error) return console.error(error);
      else console.log(JSON.stringify(result));
    });
  });
}

