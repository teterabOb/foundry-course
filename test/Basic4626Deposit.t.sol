// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";
import {CommonBase} from "forge-std/Base.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {StdUtils} from "forge-std/StdUtils.sol";
import {StdAssertions} from "forge-std/StdAssertions.sol";
import {ERC20} from "src/ERC20.sol";
import {Basic4626Deposit} from "src/Basic4626Deposit.sol";
import {ObservdevToken} from "src/ERC20.sol";

contract Handler is StdAssertions, StdUtils {
    IERC20 private asset;
    Basic4626Deposit private basicDeposit;
    uint256 public sumBalanceOf = 0;

    constructor(address _token, address _deposit){
        asset = IERC20(_token);
        basicDeposit = Basic4626Deposit(_deposit);
    }

    function deposit(uint256 assets_, address receiver_) public virtual{
        assets_ = bound(assets_, 1, 1e30);
        asset.mint(address(this), 1e30);
        asset.approve(address(basicDeposit), assets_);
        uint256 shares = basicDeposit.deposit(assets_, receiver_);
        sumBalanceOf += shares;
    }

    function transfer(address recipient_, uint256 assets_, address receiver_) public virtual{        
        deposit(assets_, receiver_);
        bool isDeposited = basicDeposit.transfer(recipient_, assets_);
        assertEq(isDeposited, true);
    }
    
}

contract Basic4626DepositTest is Test {
    IERC20 private asset;
    ObservdevToken private observdevToken;
    Basic4626Deposit private basicDeposit;
    Handler private handler;

    function setUp() public {
        observdevToken = new ObservdevToken();
        basicDeposit = new Basic4626Deposit(observdevToken.name(), observdevToken.symbol(), observdevToken.decimals(), address(observdevToken));
        asset = IERC20(address(observdevToken));
        handler = new Handler(address(observdevToken), address(basicDeposit));
        targetContract(address(handler));
    }

    function invariant_total_balance() public {
        assertEq(asset.balanceOf(address(basicDeposit)), handler.sumBalanceOf());
    }
}

interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 value) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 value) external returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
    function mint(address, uint) external;
}



