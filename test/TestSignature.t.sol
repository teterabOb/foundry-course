// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import "forge-std/Test.sol";

contract TestSign is Test {
    
    function testSigneMessage() public {        
        (address alice, uint256 alicePk) = makeAddrAndKey("alice");
        emit log_address(alice);
        emit log_uint(alicePk);

        bytes32 messageHashed = keccak256("Signed by Alice");
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(alicePk, messageHashed);
        address signer = ecrecover(messageHashed, v, r, s);
        assertEq(signer, alice);
    }

    function testSigneMessageCreateWallet() public {        
        address aliceAddress = vm.createWallet("alice").addr;
        uint256 alicePk = vm.createWallet("alice").privateKey;
        bytes32 messageHashed = keccak256("Signed by Alice");
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(alicePk, messageHashed);
        address signer = ecrecover(messageHashed, v, r, s);
        emit log_address(signer);
        assertEq(aliceAddress, signer);
    }
}
