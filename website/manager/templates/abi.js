var myABI = [
	{
		"constant": true,
		"inputs": [
			{
				"name": "_ruleId",
				"type": "uint8"
			},
			{
				"name": "_memberId",
				"type": "string"
			},
			{
				"name": "_clubId",
				"type": "string"
			}
		],
		"name": "getRule",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			},
			{
				"name": "",
				"type": "uint256"
			},
			{
				"name": "",
				"type": "uint256"
			},
			{
				"name": "",
				"type": "uint256"
			},
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
		"constant": false,
		"inputs": [
			{
				"name": "_memberId",
				"type": "string"
			},
			{
				"name": "_clubId",
				"type": "string"
			},
			{
				"name": "_authority",
				"type": "uint8"
			}
		],
		"name": "memberCreate",
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
		"outputs": [
			{
				"name": "",
				"type": "bool"
			}
		],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "_memberId",
				"type": "string"
			},
			{
				"name": "_clubId",
				"type": "string"
			}
		],
		"name": "getMemberInfo",
		"outputs": [
			{
				"name": "",
				"type": "uint8"
			},
			{
				"name": "",
				"type": "uint16"
			},
			{
				"name": "",
				"type": "uint256"
			},
			{
				"name": "",
				"type": "address"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_memberId",
				"type": "string"
			},
			{
				"name": "_clubId",
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
		"name": "ruleCreateType1",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
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
				"type": "bytes32[]"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "ruleId",
				"type": "uint8"
			},
			{
				"name": "_memberId",
				"type": "string"
			},
			{
				"name": "_clubId",
				"type": "string"
			},
			{
				"name": "_balance",
				"type": "uint256"
			}
		],
		"name": "setRuleBalance",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_memberId",
				"type": "string"
			},
			{
				"name": "_clubId",
				"type": "string"
			}
		],
		"name": "memberDelete",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "ruleId",
				"type": "uint8"
			},
			{
				"name": "_memberId",
				"type": "string"
			},
			{
				"name": "_clubId",
				"type": "string"
			},
			{
				"name": "_numberOfAbsence",
				"type": "uint8"
			}
		],
		"name": "setRuleNumberOfAbsence",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_memberId",
				"type": "string"
			},
			{
				"name": "_clubId",
				"type": "string"
			}
		],
		"name": "transferToClub",
		"outputs": [],
		"payable": true,
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "totalBalance",
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
		"constant": false,
		"inputs": [
			{
				"name": "ruleId",
				"type": "uint8"
			},
			{
				"name": "_memberId",
				"type": "string"
			},
			{
				"name": "_clubId",
				"type": "string"
			},
			{
				"name": "_numberOfLateness",
				"type": "uint8"
			}
		],
		"name": "setRuleNumberOfLateness",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
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
		"name": "club",
		"outputs": [
			{
				"name": "id",
				"type": "bytes32"
			},
			{
				"name": "numberOfMember",
				"type": "uint32"
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
		"constant": false,
		"inputs": [
			{
				"name": "ruleId",
				"type": "uint8"
			},
			{
				"name": "_memberId",
				"type": "string"
			},
			{
				"name": "_clubId",
				"type": "string"
			},
			{
				"name": "_time",
				"type": "uint256"
			}
		],
		"name": "setRuleTime",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_memberId",
				"type": "string"
			},
			{
				"name": "_clubId",
				"type": "string"
			},
			{
				"name": "_time",
				"type": "uint256"
			},
			{
				"name": "_balance",
				"type": "uint256"
			},
			{
				"name": "_numberOfLateness",
				"type": "uint8"
			},
			{
				"name": "_numberOfAbsence",
				"type": "uint8"
			}
		],
		"name": "ruleCreateType2",
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
				"name": "ruleId",
				"type": "uint8"
			},
			{
				"indexed": false,
				"name": "_memberId",
				"type": "string"
			},
			{
				"indexed": false,
				"name": "_clubId",
				"type": "string"
			}
		],
		"name": "ruleCreated",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"name": "_id",
				"type": "string"
			},
			{
				"indexed": false,
				"name": "_clubId",
				"type": "string"
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
			}
		],
		"name": "ClubCreated",
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
	}
];