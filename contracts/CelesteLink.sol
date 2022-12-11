//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";

interface CelestePost {
	function getScore() external view returns (uint256);
}

contract CelesteLink is Initializable, AccessControlUpgradeable {
	function initialize() external initializer {
		_grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
	}

	function getPostScore(address postAddress) public view returns (uint256) {
		return CelestePost(postAddress).getScore();
	}

	function getVersion() public pure returns (uint256) {
		return 1;
	}
}
