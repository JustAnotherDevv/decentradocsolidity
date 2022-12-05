const Owner = artifacts.require("./Owner.sol");
const DocOwnership = artifacts.require("./DocOwnership.sol");

module.exports = function (deployer) {
  deployer.deploy(Owner);
  deployer.deploy(DocOwnership);
};
