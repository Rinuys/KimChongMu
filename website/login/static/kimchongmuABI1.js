var kimchongmuABI = [
	{
		"constant": false,
		"inputs": [
			{
				"name": "_clubId",
				"type": "string"
			},
			{
				"name": "_memberId",
				"type": "address"
			},
			{
				"name": "_authority",
				"type": "uint8"
			}
		],
		"name": "addMemberInClub",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_clubId",
				"type": "string"
			},
			{
				"name": "_meetingId",
				"type": "string"
			},
			{
				"name": "_time",
				"type": "uint256"
			},
			{
				"name": "_memberId",
				"type": "address"
			}
		],
		"name": "addMemberInMeeting",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_clubId",
				"type": "string"
			}
		],
		"name": "clubCreate",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_clubId",
				"type": "string"
			},
			{
				"name": "_meetingId",
				"type": "string"
			},
			{
				"name": "_time",
				"type": "uint256"
			},
			{
				"name": "_balance",
				"type": "uint256"
			}
		],
		"name": "meetingCreate",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [],
		"name": "memberCreate",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"name": "_clubId",
				"type": "string"
			},
			{
				"indexed": false,
				"name": "_memberId",
				"type": "address"
			}
		],
		"name": "clubCreated",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"name": "_clubId",
				"type": "string"
			},
			{
				"indexed": false,
				"name": "_meetingId",
				"type": "string"
			},
			{
				"indexed": false,
				"name": "_memberId",
				"type": "address"
			}
		],
		"name": "memberAddedInMeeting",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"name": "_from",
				"type": "string"
			},
			{
				"indexed": false,
				"name": "_to",
				"type": "string"
			},
			{
				"indexed": false,
				"name": "_value",
				"type": "uint256"
			}
		],
		"name": "transferTo",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"name": "_clubId",
				"type": "string"
			},
			{
				"indexed": false,
				"name": "_meetingId",
				"type": "string"
			}
		],
		"name": "meetingCreated",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"name": "_memberId",
				"type": "address"
			}
		],
		"name": "memberCreated",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"name": "_clubId",
				"type": "string"
			},
			{
				"indexed": false,
				"name": "_memberId",
				"type": "address"
			}
		],
		"name": "memberAddedInClub",
		"type": "event"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "",
				"type": "bytes32"
			}
		],
		"name": "club",
		"outputs": [
			{
				"name": "id",
				"type": "string"
			},
			{
				"name": "numberOfMember",
				"type": "uint32"
			},
			{
				"name": "numberOfMeeting",
				"type": "uint8"
			},
			{
				"name": "balance",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "_clubId",
				"type": "string"
			}
		],
		"name": "getClubBalance",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "_clubId",
				"type": "string"
			}
		],
		"name": "getClubInfo",
		"outputs": [
			{
				"name": "",
				"type": "uint32"
			},
			{
				"name": "",
				"type": "uint256"
			},
			{
				"name": "",
				"type": "address[]"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "getContractBalance",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "_memberId",
				"type": "address"
			}
		],
		"name": "getMemberInfo",
		"outputs": [
			{
				"name": "",
				"type": "address"
			},
			{
				"name": "",
				"type": "uint32"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "getNumberOfClub",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "getNumberOfMeeting",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "getNumberOfMember",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "_clubId",
				"type": "string"
			}
		],
		"name": "isClubIdExist",
		"outputs": [
			{
				"name": "",
				"type": "bool"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "_clubId",
				"type": "string"
			},
			{
				"name": "_meetingId",
				"type": "string"
			},
			{
				"name": "_time",
				"type": "uint256"
			}
		],
		"name": "isMeetingIdExist",
		"outputs": [
			{
				"name": "",
				"type": "bool"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "",
				"type": "bytes32"
			}
		],
		"name": "meeting",
		"outputs": [
			{
				"name": "id",
				"type": "string"
			},
			{
				"name": "clubId",
				"type": "string"
			},
			{
				"name": "time",
				"type": "uint256"
			},
			{
				"name": "balance",
				"type": "uint256"
			},
			{
				"name": "numberOfMember",
				"type": "uint32"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "",
				"type": "address"
			}
		],
		"name": "member",
		"outputs": [
			{
				"name": "id",
				"type": "address"
			},
			{
				"name": "numberOfClub",
				"type": "uint32"
			},
			{
				"name": "numberOfMeeting",
				"type": "uint8"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	}
];