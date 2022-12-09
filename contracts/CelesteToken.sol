//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Celeste is ERC20 {
	address payable immutable i_owner;
	uint256 private s_fee;

	constructor(uint256 initialSupply, uint256 initialFee)
		public
		ERC20("Celeste", "CST")
	{
		_mint(msg.sender, initialSupply);
		i_owner = msg.sender;
	}

	function _beforeTokenTransfer(
		address from,
		address to,
		uint256 value
	) internal virtual override {
		transfer(msg.sender, (value * s_fee) / 100);
		super._beforeTokenTransfer(from, to, value);
	}

	function setFee(uint256 fee) public {
		s_fee = fee;
	}

	function getFee() public returns (uint256) {
		return s_fee;
	}
}
