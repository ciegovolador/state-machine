pragma solidity ^0.5.0;


import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/StateMachine.sol";

contract testSM {

StateMachine sm = StateMachine(DeployedAddresses.StateMachine());

uint expectedState = 0;

address expectedAdress = address(this);


function testGetState() public {
  uint returnedState = uint(sm.getState());

  Assert.equal(returnedState, expectedState, "Adoption of the expected pet should match what is returned.");
}
}
