const hre = require("hardhat");

async function main() {

  const [owner, other] = await ethers.getSigners();

  const Basic_Descriptor = await hre.ethers.getContractFactory("Basic_Descriptor");
  const descriptor = await Basic_Descriptor.deploy("http://localhost:3000/api/metadata/");
  await descriptor.deployed();
  console.log(`Basic Descriptor contract deployed to ${descriptor.address}`);

  const City = await hre.ethers.getContractFactory("City");
  const city = await City.deploy(100, descriptor.address);
  await city.deployed();
  console.log(`City contract deployed to ${city.address}`);

  const BuildingManager = await hre.ethers.getContractFactory("BuildingManager");
  const buildingManager = await BuildingManager.deploy(city.address);
  await buildingManager.deployed();
  console.log(`Building Manager contract deployed to ${buildingManager.address}`);

  // const House = await hre.ethers.getContractFactory("House");
  // const house = await House.deploy(buildingManager.address, chunk.address);
  // await house.deployed();
  // console.log(`House (Building) deployed to ${house.address}`);

  const Farm = await hre.ethers.getContractFactory("Farm");
  const farm = await Farm.deploy(buildingManager.address, city.address);
  await farm.deployed();
  console.log(`Farm (Building) contract deployed to ${farm.address}`);

  const Food = await hre.ethers.getContractFactory("Food");
  const food = await Food.deploy(city.address, farm.address);
  await food.deployed();
  console.log(`Food (Unit) contract deployed to ${food.address}`);
  await farm.setFood(food.address);

  await city.mint();
  console.log(`Minted 1 City`);

  for (let i = 0; i < 10; i++) {
    await city.connect(other).mint();
  }
  console.log(`Minted 10 Cities to Other Account`);

  for (let i = 0; i < 10; i++) {
    await city.mint();
  }
  console.log(`Minted 10 More Cities to Owner Account`);

  // await buildingManager.registerBuilding(house.address);
  // console.log(`Registered HOUSING in Building Manager (0)`);
  await buildingManager.registerBuilding(farm.address);
  console.log(`Registered FARM in Building Manager (1)`);

  /**
   * Usage: addBuildingTo(buildingId, tokenId, tier)
   */
  await buildingManager.addBuildingTo(0, 0, 0);
  console.log(`Built Tier 0 Farm on City #0`);
  await buildingManager.addBuildingTo(0, 0, 2);
  console.log(`Built Tier 2 Farm on City #0`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
