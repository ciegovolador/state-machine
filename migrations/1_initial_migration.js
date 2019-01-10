var Migrations = artifacts.require("./Migrations.sol");

var StateMachine = artifacts.require("./StateMachine.sol");

module.exports = function(deployer) {

deployer.deploy(Migrations);

deployer.deploy(StateMachine);

};
