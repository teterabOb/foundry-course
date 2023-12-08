// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

contract University {
    uint256 public startDate = block.timestamp + 1 days;
    uint256 public endDate = block.timestamp + 2 days;

    function enroll() public {
        require(block.timestamp >= startDate && block.timestamp < endDate, "cannot enroll");
    }

    function leave() public {
        require(block.timestamp >= endDate, "cannot leave");
    }
}
