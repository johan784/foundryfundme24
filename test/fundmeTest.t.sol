//SPDXLicense-Identifier: MIT;
pragma solidity ^0.8.18;

import{Test, console } from "forge-std/Test.sol";
import{FundMe}from "src/fundme.sol";
import{Deployfundme}from "script/Deployfundme.s.sol";

contract fundmeTest is Test{
FundMe fundme;

address alice = makeAddr("alice");
uint256 gas_price=1;
   

    function setUp() external {

        //fundme= new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        Deployfundme deployfundme= new Deployfundme();
        fundme=deployfundme.run();


       
       

       
    }

    function testMinimumUSDtestdemo() public {


        console.logAddress(fundme.owner());
        console.logAddress(msg.sender);
       assertEq(fundme.owner(),msg.sender);
    }

       function testaggregatorv3version() public {
        uint256 version=fundme.getVersion();
        assertEq(version, 4);
       }

function testIfEnoughEthIsSent() public {
    vm.expectRevert();
    fundme.fund();

}
function testEth() public{
    address alice= makeAddr("alice");
     uint256 balance = 10 ether;

    vm.deal(alice, balance);
     

    vm.prank(alice);
    fundme.fund{value :10 ether}();
    vm.prank(alice);
    uint256 bb= fundme.getamt(alice);
    assertEq(bb,10 ether);
}

modifier funde(){

   

    vm.prank(alice);
    uint256 balance= 20 ether;
    vm.deal(alice,balance);
    fundme.fund{value:balance}();
    assert(address(fundme).balance>0);
    _;

}
function testfunder() public funde{

   vm.prank(alice);
    address x= fundme.getfunder(0);
    assertEq(x,alice);
}

function testcheckwithdrawer() public funde{

    vm.prank(alice);
    vm.expectRevert();
    fundme.withdraw();
    


}

function testifownercanget() public funde{

    vm.txGasPrice(gas_price);
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

function testMultipleFunders() public {
    uint160 numberOfFunders = 10;
    uint160 startingIndex = 1;
    uint160 i;

    // Simulate multiple funders funding the contract
    for (i = startingIndex; i <= numberOfFunders; i++) {
        // Give each funder an address and some balance
        address funderAddress = address(i);
        hoax(funderAddress, 10 ether); // Sets msg.sender and gives the address a balance
        
        // Fund the contract with 10 ether from this address
        fundme.fund{value: 10 ether}();
    }

    // Check balances before withdrawal
    uint256 startingFundMeBalance = address(fundme).balance;
    uint256 startingOwnerBalance = fundme.owner().balance;

    // Withdraw the funds as the owner
    vm.prank(fundme.owner()); // Ensure the owner is msg.sender for withdrawal
    fundme.withdraw();

    // Ensure the contract balance is zero after withdrawal
    assertEq(address(fundme).balance, 0);

    // Check balances after withdrawal
    uint256 endingFundMeBalance = address(fundme).balance;
    uint256 endingOwnerBalance = fundme.owner().balance;

    // Assert that the owner's ending balance is equal to the starting owner balance plus the contract's starting balance
    assertEq(startingFundMeBalance + startingOwnerBalance, endingOwnerBalance);
}


    





    }
