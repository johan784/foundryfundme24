//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import{Script} from "forge-std/Script.sol";
import{FundMe} from "src/fundme.sol";
import{MockV3Aggregator}from"test/mocks/mockV3Aggregator.sol";


contract HelperConfig is  Script {

uint8 public constant _decimal= 8;
int256 public constant _initialAnswer= 2000e8;
    NetworkConfig public activeNetworkconfig;
     struct NetworkConfig{
        address priceFeedAddress;
     }

     constructor(){
        if(block.chainid== 11155111){
            activeNetworkconfig= getSepoliaEthConfig();
        }else{
            activeNetworkconfig= getAnvilEthConfig();
        }
     }

     

    function getSepoliaEthConfig() public   pure returns (NetworkConfig memory){

       NetworkConfig memory sepoliaconfig = NetworkConfig({priceFeedAddress: address(0x694AA1769357215DE4FAC081bf1f309aDC3253)});
        return sepoliaconfig;


        //price feed address 
    }

    function getAnvilEthConfig() public returns(NetworkConfig memory){
        
            if (activeNetworkconfig.priceFeedAddress != address(0)) {
    return activeNetworkconfig;

}
        

        vm.startBroadcast();
        MockV3Aggregator mockV3Aggregator= new MockV3Aggregator(_decimal, _initialAnswer);
            
        vm.stopBroadcast();

        NetworkConfig memory anvilConfig = NetworkConfig({priceFeedAddress:address(mockV3Aggregator)});
        return anvilConfig;

        
    } 
}