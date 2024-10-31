// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;



import{Script} from "lib/forge-std/src/Script.sol";
import{FundMe} from "src/fundme.sol";
import{HelperConfig} from"script/HelperConfig.s.sol";

contract Deployfundme is Script{

    

     function run() external payable returns (FundMe){

      HelperConfig helperconfig= new HelperConfig();
      address ethPriceFeedAddress= helperconfig.activeNetworkconfig();

        vm.startBroadcast();
       FundMe fundme= new FundMe(ethPriceFeedAddress);
        vm.stopBroadcast();

        return fundme;
    
     }
}