// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

contract University {
    uint256 public startDate = block.timestamp + 1 days;
    uint256 public endDate = block.timestamp + 2 days;

    function enroll() public {
        require(block.timestamp >= startDate && block.timestamp < endDate, "can't enroll");
    }

    function leave() public {
        require(block.timestamp >= endDate, "can't leave");
    }
}