// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "solmate/tokens/ERC20.sol";

contract Token2 is ERC20 {
    constructor() ERC20("Founfry Esp", "FES", 18) { }
}

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract TokenOz is ERC721("Foundry Esp", "FES") { }