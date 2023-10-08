pragma solidity 0.8.10;

import "forge-std/Test.sol";

contract Console is Test {
    
    function test_LogDeployer() public view {
        console.log("Log deployer :", "mostrando el log");
    }

}
