const hre = require("hardhat");

async function main() {

  const [owner] = await ethers.getSigners();

  const Basic_Descriptor = await hre.ethers.getContractFactory("Basic_Descriptor");
  const descriptor = await Basic_Descriptor.deploy("http://localhost:3000/api/metadata/");
  await descriptor.deployed();
  console.log(`Descriptor has been deployed to ${descriptor.address}`);

  const ChunkNFT = await hre.ethers.getContractFactory("Chunk");
  const chunk = await ChunkNFT.deploy(100, descriptor.address);
  await chunk.deployed();
  console.log(`Chunk has been deployed to ${chunk.address}`);

  const BuildingManager = await hre.ethers.getContractFactory("BuildingManager");
  const buildingManager = await BuildingManager.deploy(chunk.address);
  await buildingManager.deployed();
  console.log(`Building Manager deployed to ${buildingManager.address}`);

  const House = await hre.ethers.getContractFactory("House");
  const house = await House.deploy(buildingManager.address, chunk.address);
  await house.deployed();
  console.log(`House (Building) deployed to ${house.address}`);

  await chunk.mintChunk();
  await chunk.mintChunk();
  console.log(`Minted 2 Chunks`);

  await buildingManager.registerBuilding(house.address);
  console.log(`Registered HOUSING in Building Manager`);

  await buildingManager.addBuildingTo(0, 0, 2);
  console.log(`Built 2 houses on land id 0`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
