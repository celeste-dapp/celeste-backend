//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721BurnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";

contract CelestePost is
	Initializable,
	ERC721Upgradeable,
	ERC721BurnableUpgradeable,
	AccessControlUpgradeable
{
	using CountersUpgradeable for CountersUpgradeable.Counter;

	bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
	CountersUpgradeable.Counter private _tokenIdCounter;
	string public postURI;

	function initialize() external initializer {
		__ERC721_init("Celeste Post", "CSTP");
		_grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
		_grantRole(MINTER_ROLE, msg.sender);
	}

	function safeMint(address to, string memory _postURI)
		public
		onlyRole(MINTER_ROLE)
	{
		uint256 tokenId = _tokenIdCounter.current();
		_tokenIdCounter.increment();
		_safeMint(to, tokenId);
		postURI = _postURI;
	}

	function tokenURI(
		uint256 /*tokenId*/
	) public view override returns (string memory) {
		return postURI;
	}

	function supportsInterface(bytes4 interfaceId)
		public
		view
		override(ERC721Upgradeable, AccessControlUpgradeable)
		returns (bool)
	{
		return super.supportsInterface(interfaceId);
	}

	function getPostScore() public view returns (uint256) {}

	function getTotalPostScore() public view returns (uint256) {}

	function getVersion() public pure returns (uint256) {
		return 1;
	}
}
