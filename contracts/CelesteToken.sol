//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Celeste is ERC20 {
	address payable immutable i_owner;
	uint256 public s_fee;

	constructor(uint256 initialSupply, uint256 initialFee)
		ERC20("Celeste", "CST")
	{
		_mint(msg.sender, initialSupply);
		s_fee = initialFee;
		i_owner = payable(msg.sender);
	}

	function transfer(address _to, uint256 _value)
		public
		override
		returns (bool)
	{
		_transfer(msg.sender, i_owner, (_value * s_fee) / 100);
		_transfer(msg.sender, _to, (_value * (100 - s_fee)) / 100);
		return true;
	}

	function setFee(uint256 fee) public {
		s_fee = fee;
	}

	function getFee() public view returns (uint256) {
		return s_fee;
	}
}
