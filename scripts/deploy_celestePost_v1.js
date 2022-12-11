const { INITIAL_SUPPLY, INITIAL_FEE, developmentChains } = require("../helper-hardhat-config")
const { verify } = require("../helper-functions")
const { ethers, upgrades } = require("hardhat")

async function main() {
	console.log("Deploying CelestePost V1 Proxy")
	const CelestePost = await ethers.getContractFactory("CelestePost")
	const celestePost = await upgrades.deployProxy(CelestePost, [], {
		initializer: "initialize",
	})
	await celestePost.deployed()

	console.log("CelestePost deployed to:", celestePost.address)

	if (!developmentChains.includes(network.name) && process.env.ETHERSCAN_API_KEY) {
		await verify(celestePost.address, [], "CelestePost.sol:CelestePost")
	}
}

main()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error)
		process.exit(1)
	})
