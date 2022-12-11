//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface CelestePost {
	function getScore() external view returns (uint256);

	function getTotalScore() external view returns (uint256);
}

contract CelesteLink is Initializable, AccessControlUpgradeable {
	address public CelesteTokenAddress;

	function initialize(address _CelesteTokenAddress) external initializer {
		_grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
		CelesteTokenAddress = _CelesteTokenAddress;
	}

	function getPostScore(address postAddress) public view returns (uint256) {
		return CelestePost(postAddress).getScore();
	}

	function getTotalPostScore(address postAddress)
		public
		view
		returns (uint256)
	{
		return CelestePost(postAddress).getTotalScore();
	}

	function getPostValue(address postAddress) public view returns (uint256) {
		return
			(getPostScore(postAddress) / getTotalPostScore(postAddress)) *
			IERC20(CelesteTokenAddress).balanceOf(address(this));
	}

	function getVersion() public pure returns (uint256) {
		return 1;
	}
}
