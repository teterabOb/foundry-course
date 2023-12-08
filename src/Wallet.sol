// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

contract Wallet {
    event Deposited(address indexed sender);

    address private owner;

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {
        emit Deposited(msg.sender);
    }

    function withdrawAll() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

    function getOwner() public view returns (address) {
        return owner;
    }

    function setOwner(address _address) external onlyOwner {
        owner = _address;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only Owner");
        _;
    }
}
