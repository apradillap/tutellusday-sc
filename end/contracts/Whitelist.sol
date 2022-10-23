// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.7;

contract Whitelist {

    address public owner;
    mapping (address => uint256) public votingPower;

    constructor () {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only owner");
        _;
    }

    function _add (
        address account
    )
        private
    {
        require(votingPower[account] == 0, "Already whitelisted");
        votingPower[account] = 1;
    }

    function _remove (
        address account
    )
        private
    {
        require(votingPower[account] > 0, "Not whitelisted");
        votingPower[account] = 0;
    }

    function add (
        address account
    )
        public
        onlyOwner
    {
        _add(account);
    }

    function remove (
        address account
    )
        public
        onlyOwner
    {
        _remove(account);
    }

    function addBatch (
        address[] memory accounts
    )
        public
        onlyOwner
    {
        for (uint256 i = 0; i < accounts.length; i++) {
            _add(accounts[i]);
        }
    }

    function removeBatch (
        address[] memory accounts
    )
        public
        onlyOwner
    {
        for (uint256 i = 0; i < accounts.length; i++) {
            _remove(accounts[i]);
        }
    }
}