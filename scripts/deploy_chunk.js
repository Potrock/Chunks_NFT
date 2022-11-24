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

  // const House = await hre.ethers.getContractFactory("House");
  // const house = await House.deploy(buildingManager.address, chunk.address);
  // await house.deployed();
  // console.log(`House (Building) deployed to ${house.address}`);

  const Farm = await hre.ethers.getContractFactory("Farm");
  const farm = await Farm.deploy(buildingManager.address, chunk.address);
  await farm.deployed();
  console.log(`Farm (Building) deployed to ${farm.address}`);

  const Food = await hre.ethers.getContractFactory("Food");
  const food = await Food.deploy(chunk.address, farm.address);
  await food.deployed();
  console.log(`Food (unit) deployed to ${food.address}`);
  await farm.setFood(food.address);

  await chunk.mintChunk();
  console.log(`Minted 1 Chunk`);

  // await buildingManager.registerBuilding(house.address);
  // console.log(`Registered HOUSING in Building Manager (0)`);
  await buildingManager.registerBuilding(farm.address);
  console.log(`Registered FARM in Building Manager (1)`);

  /**
   * Usage: addBuildingTo(buildingId, tokenId, tier)
   */
  await buildingManager.addBuildingTo(0, 0, 0);
  console.log(`Built Tier 1 Farm on Chunk #0`)
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
