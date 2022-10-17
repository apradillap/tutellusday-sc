const hre = require("hardhat");

const TOKEN = "0xC4B2dbE0cDc5BAa02a100028BcD8Fd5005276Bc6";

async function main() {
  await hre.run('compile');
  const Staking = await hre.ethers.getContractFactory("Staking");
  const staking = await Staking.deploy(TOKEN);
  await staking.deployed();
  console.log("Staking deployed to:", staking.address);
}

main();
