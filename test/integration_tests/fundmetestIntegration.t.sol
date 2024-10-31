//SPDX-License-identifier: MIT
pragma solidity ^0.8.18;

import{Test,console} from "forge-std/Test.sol";
import {FundMe} from "src/fundme.sol";
import{ FundFundMe, wihtdrawFundme} from "script/Interactions.s.sol";
import{Deployfundme}from "script/Deployfundme.s.sol";
import "forge-std/Test.sol";


contract fundmeIntegration is Test{

    FundMe public fundme;


    address alice = makeAddr("alice");

    function setUp() external {
        Deployfundme depo= new Deployfundme();
        fundme = depo.run();
        vm.deal(alice, 10 ether);
    }

    function testifusercanwithdraw() public{

       
    uint256 startgas= gasleft();

    uint256 startingfundmebalance= address(fundme).balance;
    uint256 startingownerbalance=fundme.owner().balance;

    vm.startPrank(fundme.owner());
    fundme.withdraw();
    assertEq(address(fundme).balance,0);

    uint256 endinggas= gasleft();

    uint256 gasUsed= (startgas-endinggas)*tx.gasprice;
    console.log(" the amount of gas used is %d",gasUsed);
    
    uint256 endingfundmebalance=address(fundme).balance;
    uint256 endingownerbalance=fundme.owner().balance;

    assertEq(startingfundmebalance + startingownerbalance,endingownerbalance);


    
}
    }





    
