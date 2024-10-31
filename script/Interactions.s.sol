//creatinf a fund script and a withdraw script 

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import{ Script, console}from "forge-std/Script.sol";
import{FundMe}from "src/fundme.sol";    
import{DevOpsTools} from"lib/foundry-devops/src/DevOpsTools.sol";

contract FundFundMe is Script{

    function run() external view returns(address){
        address mostRecent= DevOpsTools.get_most_recent_deployment("FundMe",block.chainid);
        return mostRecent;

    }

    function funda(address mostRecent)public{

        vm.startBroadcast();
        FundMe(payable(mostRecent)).fund{value:0.1 ether};
        vm.stopBroadcast();
        console.log(" the contract has been funded");

    }
}

contract wihtdrawFundme is Script{

 function run() external view returns(address){
        address mostRecent= DevOpsTools.get_most_recent_deployment("FundMe",block.chainid);
        return mostRecent;

    }

    function withdraw(address mostRecent)public{
        vm.startBroadcast();
        FundMe(payable(mostRecent)).withdraw();
        vm.stopBroadcast();
        console.log(" the contract has been withdrawed");
    }   
    
}




