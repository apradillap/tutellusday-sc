// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.7;

import "./Token.sol";

contract Staking {

    address public owner;
    address public token;

    mapping (address => uint256) public balanceOf;
    mapping (address => uint256) public lastClaim;

    uint256 public constant blocksUntilReward = 10;

    uint256 public totalSupply;

    constructor (
        address token_
    ) {
        token = token_;
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only owner");
        _;
    }

    function pendingRewards (
        address account
    )
        public
        view
        returns (uint256)
    {
        uint256 balance = balanceOf[account];
        if (balance > 0) {
            uint256 blocks = block.number - lastClaim[account];
            uint256 units = blocks / blocksUntilReward;
            uint256 rewards = balance * units;
            return rewards;
        } else {
            return 0;
        }
    }

    function claim ()
        public
    {
        uint256 rewards = pendingRewards(msg.sender);
        require(rewards > 0, "Nothing to claim");
        lastClaim[msg.sender] = block.number;
        Token(token).mint(
            msg.sender,
            rewards
        );
    }

    function deposit (
        uint256 amount
    )
        public
    {
        if (pendingRewards(msg.sender) > 0) {
            claim();
        }
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        Token(token).transferFrom (
            msg.sender,
            address(this),
            amount
        );
    }

    function withdraw (
        uint256 amount
    )
        public
    {
        if (pendingRewards(msg.sender) > 0) {
            claim();
        }
        require(amount <= balanceOf[msg.sender], "Amount exceeds balance");
        balanceOf[msg.sender] -= amount;
        Token(token).transfer (
            msg.sender,
            amount
        );
    }

}