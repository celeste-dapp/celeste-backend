const { INITIAL_SUPPLY, INITIAL_FEE, developmentChains } = require("../helper-hardhat-config")
const { verify } = require("../helper-functions")
const { ethers } = require("hardhat")

async function main() {
	const { deploy, log } = deployments
	const { deployer } = await getNamedAccounts()

	const token = await deploy("Celeste", {
		from: deployer,
		args: [INITIAL_SUPPLY, INITIAL_FEE],
		// we need to wait if on a live network so we can verify properly
		waitConfirmations: network.config.blockConfirmations || 5,
	})
	log(`Celeste deployed at ${token.address}`)

	await console.log("Token address:", token.address)

	if (!developmentChains.includes(network.name) && process.env.ETHERSCAN_API_KEY) {
		await verify(token.address, [INITIAL_SUPPLY, INITIAL_FEE])
	}
}

main()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error)
		process.exit(1)
	})
