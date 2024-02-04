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
    //ObservdevToken private observdevToken;
    Basic4626Deposit private basicDeposit;
    uint256 public sumBalanceOf = 0;

    constructor(address _token, address _basicDeposit) {        
        asset = IERC20(_token);        
        basicDeposit = Basic4626Deposit(_basicDeposit);
    }

    function deposit(uint256 assets_, address receiver_) public virtual {
        //Bounded/Unbounded functions -> utilizamos bound para evitar errores de underflow/overflow
        // si parte desde 0 da error por un revert que estamos validando en el codigo
        require(receiver_ != address(0), "Handler: receiver is zero address");
        assets_ = bound(assets_, 1, 1e30); //assets_ = bound(assets_, 0, 1e30); // probar con
        asset.mint(address(this), assets_);
        asset.approve(address(basicDeposit), assets_);
        uint256 shares = basicDeposit.deposit(assets_, receiver_);
        sumBalanceOf += shares;
    }

    /*
    function transfer(address recipient_, uint256 assets_, address receiver_) public virtual {
        deposit(assets_, receiver_);
        bool isDeposited = basicDeposit.transfer(recipient_, assets_);
        assertEq(isDeposited, true);
    }
    */
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
        // Debemos setear el target contract para que ejecute
        // solo las funciones del handler
        targetContract(address(handler));
    }

    function invariant_total_balance() public {
        assertEq(asset.balanceOf(address(basicDeposit)), handler.sumBalanceOf());        
    }
}

interface IERC20 {
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
