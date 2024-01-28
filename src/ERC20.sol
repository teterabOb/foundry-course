// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ObservdevToken is ERC20 {

    constructor() ERC20("Observdev Token", "OBS") {
        _mint(msg.sender, 2_000_000 ether);
    }

    function mint(address account_, uint256 amount_) external {
        _mint(account_, amount_);
    }
}