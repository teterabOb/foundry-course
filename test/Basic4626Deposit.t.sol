// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";

contract Basic4626DepositTest is Test {}

import {CommonBase} from "forge-std/Base.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {StdUtils} from "forge-std/StdUtils.sol";
import {ERC20} from "src/ERC20.sol";
import {Basic4626Deposit} from "src/Basic4626Deposit.sol";
import {ObservdevToken} from "src/ERC20.sol";

contract Handler is CommonBase, StdCheats, StdUtils {
    IERC20Like private asset;
    ObservdevToken private observdevToken;
    Basic4626Deposit private basicDeposit;

    function setUp() public {
        observdevToken = new ObservdevToken();
        asset = IERC20Like(address(observdevToken));
    }

    function deposit(uint256 assets_) public virtual {
        asset.mint(address(msg.sender), assets_);
        asset.approve(address(basicDeposit), assets_);
        uint256 shares = basicDeposit.deposit(assets_, address(this));
    }

    function transfer(address recipient_, uint256 assets_) public virtual {
        deposit(assets_);
        basicDeposit.transfer(recipient_, assets_);
    }
}

interface IERC20Like {
    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address to, uint256 value) external returns (bool);

    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);

    function approve(address spender, uint256 value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);

    function mint(address, uint) external;
}
