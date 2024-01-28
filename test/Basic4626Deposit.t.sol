// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {Test} from "forge-std/Test.sol";


contract Basic4626DepositTest is Test {

}

import {CommonBase} from "forge-std/Base.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {StdUtils} from "forge-std/StdUtils.sol";
import {ERC20} from "src/ERC20.sol";

contract Handler is CommonBase, StdCheats, StdUtils {
    IERC20Like private asset;

    function setUp() public override {
        asset = IERC20Like(address(new ERC20()));
    }

    constructor(address asset_) {
        asset = IERC20Like(asset_);
    }

    function deposit(uint256 assets_, address receiver_) public returns (uint256){}
    function transfer(address recipient_, uint256 amount_) public returns (bool) {}    
}

interface IERC20Like {
    function balanceOf(address) external view returns (uint);

    function transferFrom(address, address, uint) external returns (bool);
}
