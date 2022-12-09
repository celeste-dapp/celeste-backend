const { ethers, upgrades } = require("hardhat")
const { etherscan } = require("../hardhat.config")

const PROXY = "0xCb1BBa43C03259CaC3B7184a2Ce4Eca5624cf858"

async function main() {
	const CelesteV2 = await etherscan.getContracFactory("CelesteV2")
	await upgrades.upgradeProxy(PROXY, CelesteV2)
	console.log("Celeste upgraded to V2!")
}

main()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error)
		process.exit(1)
	})
