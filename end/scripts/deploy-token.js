const hre = require("hardhat");

const NAME = "{TOKEN_NAME}";
const SYMBOL = "{TOKEN_SYMBOL}";

async function main() {
  await hre.run('compile');
  const Token = await hre.ethers.getContractFactory("Token");
  const token = await Token.deploy(NAME, SYMBOL);
  await token.deployed();
  console.log("Token deployed to:", token.address);
}

main();
