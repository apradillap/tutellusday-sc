const hre = require("hardhat");

const ADDRESSES = [
  "0x30729B6910757042024304E56BEB015821462691",
  "0x44eEdBEE931A5dc22a5f4Ad441679FD5C0e38D38",
  "0xDd7bEA0F495cC11d21Ee715663B21607f41DbaaF",
];

async function main() {
  await hre.run('compile');
  const Whitelist = await hre.ethers.getContractFactory("Whitelist");
  const whitelist = await Whitelist.deploy();
  await whitelist.deployed();
  console.log("Whitelist deployed to:", whitelist.address);
  const adding = await whitelist.addBatch(ADDRESSES);
  await adding.wait();
  console.log("Whitelist addresses added");
}

main();
