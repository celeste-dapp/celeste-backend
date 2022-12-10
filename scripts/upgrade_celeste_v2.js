const { developmentChains } = require("../helper-hardhat-config")
const { verify } = require("../helper-functions")
const { ethers, upgrades } = require("hardhat")

const PROXY = "0xCb1BBa43C03259CaC3B7184a2Ce4Eca5624cf858"

async function main() {
	const CelesteV2 = await ethers.getContractFactory("CelesteV2")
	const celeste = await upgrades.upgradeProxy(PROXY, CelesteV2)
	console.log("Celeste upgraded to V2!")

	if (!developmentChains.includes(network.name) && process.env.ETHERSCAN_API_KEY) {
		await verify(celeste.address, [], "CelesteTokenV2.sol:CelesteV2")
	}
}

main()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error)
		process.exit(1)
	})
