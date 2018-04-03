var Migrations = artifacts.require("./Migrations.sol");
var News = artifacts.require("./News.sol");
module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(News);
};
