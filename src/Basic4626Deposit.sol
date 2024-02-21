//SPDX-license-Identifier: UNLICENSED
pragma solidity 0.8.20;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Basic4626Deposit {
    address public immutable asset;

    string public name;
    string public symbol;
    uint8 public decimals;

    uint256 public totalSupply;

    mapping(address => uint256) public balanceOf;

    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        address _asset
    ) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        asset = _asset;
    }

    function deposit(uint256 assets_, address receiver_) external returns(uint256 shares_) {
        shares_ = convertToShares(assets_);

        require(receiver_ != address(0), "Basic4626Deposit: receiver is zero address");
        require(assets_ > 0, "Basic4626Deposit: assets is zero");
        require(shares_ > 0, "Basic4626Deposit: shares is zero");

        totalSupply += shares_;

        balanceOf[receiver_] += shares_;

        require(IERC20(asset).transferFrom(msg.sender, address(this), assets_), "Basic4626Deposit: transferFrom failed");
    }

    function transfer(address recipient_, uint256 amount_) external returns(bool){
        balanceOf[msg.sender] -= amount_;
        balanceOf[recipient_] += amount_;
        return true;
    }


    function convertToShares(uint256 assets_) internal view returns(uint256 shares_) {
        uint256 supply_ = totalSupply;
        shares_ = supply_ == 0 ? assets_ : assets_ * supply_ / IERC20(asset).balanceOf(address(this));
    }

    function totalAssets() public view returns(uint256) {
        return IERC20(asset).balanceOf(address(this));
    }
}
