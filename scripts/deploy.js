// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  const Descriptor = await hre.ethers.getContractFactory("Chunk_Descriptor");
  const descriptor = await Descriptor.deploy("http://localhost:3000/api/metadata/");

  await descriptor.deployed();

  const Chunk = await hre.ethers.getContractFactory("Chunk");
  const chunk = await Chunk.deploy(100, descriptor.address)

  await chunk.deployed();

  console.log(`Chunk has been deployed to ${chunk.address} and descriptor has been deployed to ${descriptor.address}`)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
