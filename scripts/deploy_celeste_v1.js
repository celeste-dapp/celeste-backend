const { INITIAL_SUPPLY, INITIAL_FEE, developmentChains } = require("../helper-hardhat-config")
const { verify } = require("../helper-functions")
const { ethers, upgrades } = require("hardhat")

async function main() {
	console.log("Deploying Celeste V1 Proxy")
	const Celeste = await ethers.getContractFactory("Celeste")
	const celeste = await upgrades.deployProxy(Celeste, [INITIAL_SUPPLY, INITIAL_FEE], {
		initializer: "initialize",
	})
	await celeste.deployed()

	console.log("Celeste deployed to:", celeste.address)

	if (!developmentChains.includes(network.name) && process.env.ETHERSCAN_API_KEY) {
		await verify(celeste.address, [INITIAL_SUPPLY, INITIAL_FEE], "CelesteToken.sol:Celeste")
	}
}

main()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error)
		process.exit(1)
	})
