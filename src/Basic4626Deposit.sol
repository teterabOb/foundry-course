//SPDX-license-Identifier: UNLICENSED
pragma solidity 0.8.20;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Basic4626Deposit {
    address public immutable asset;

    string public name;
    string public symbol;

    uint8 public immutable decimals;

    uint256 public totalSupply;

    mapping(address => uint256) public balanceOf;

    constructor(
        address asset_,
        string memory name_,
        string memory symbol_,
        uint8 decimals_
    ) {
        asset = asset_;
        name = name_;
        symbol = symbol_;
        decimals = decimals_;
    }

    function deposit(uint256 assets_, address receiver_) external returns(uint256 shares_){
        shares_ = convertToShares(assets_);

        require(receiver_ != address(0), "Basic4626Deposit: receiver is zero address");
        require(shares_ > 0, "Basic4626Deposit: shares is zero");
        require(assets_ > 0, "Basic4626Deposit: assets is zero");

        totalSupply += shares_;

        // No puede ocurrir el overflow porque totalSupply hubiera sido mayor a 2^256 en la linea anterior
        unchecked {
            balanceOf[receiver_] += shares_;
        }

        require(
            IERC20(asset).transferFrom(msg.sender, address(this), assets_),
            "Basic4626Deposit: transferFrom failed"
        );                        
    }

    function transfer(address recipient_, uint256 amount_) external returns (bool) {
        balanceOf[msg.sender] -= amount_;

        unchecked {
            balanceOf[recipient_] += amount_;
        }

        return true;
    }

    function convertToShares(uint256 assets_) public view returns (uint256 shares_) {
        uint256 supply_ = totalSupply;

        shares_ = supply_ == 0 ? assets_ : (assets_ * supply_) / totalAssets();
    }

    function totalAssets() public view returns (uint256 assets_) {
        assets_ = IERC20(asset).balanceOf(address(this));
    }

}
