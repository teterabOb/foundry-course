// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

contract Wallet {
    event Deposited(address indexed sender);

    address private owner;

    constructor(){
        owner = msg.sender;
    }

    receive() external payable {
        emit Deposited(msg.sender);
    }

    //payable(msg.sender).transfer(_amount);
    function withdrawAll(uint256 _amount) external  {
        require(address(this).balance > 0, "Not enough eth");
        payable(owner).transfer(_amount);
    }

    function getOwner() public view returns(address) {
        return owner;
    }

    function setOwner(address _address) onlyOwner external {
        owner = _address;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only Owner");
        _;
    }
}