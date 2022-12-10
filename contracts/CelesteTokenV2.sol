//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract CelesteV2 is Initializable, ERC20Upgradeable, OwnableUpgradeable {
	uint256 public s_fee;
	uint256 public s_burn;

	function mint(address to, uint256 amount) external onlyOwner {
		_mint(to, amount);
	}

	function transfer(address _to, uint256 _value)
		public
		override
		returns (bool)
	{
		_burn(msg.sender, (_value * s_burn) / 100);
		_transfer(msg.sender, owner(), (_value * s_fee) / 100);
		_transfer(msg.sender, _to, (_value * (100 - s_fee - s_burn)) / 100);
		return true;
	}

	function setFee(uint256 fee) public onlyOwner {
		s_fee = fee;
	}

	function setBurn(uint256 burn) public onlyOwner {
		s_burn = burn;
	}

	function getFee() public view returns (uint256) {
		return s_fee;
	}

	function getBurn() public view returns (uint256) {
		return s_burn;
	}

	function getVersion() public pure returns (uint256) {
		return 2;
	}
}
