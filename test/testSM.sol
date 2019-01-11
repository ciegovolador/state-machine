pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/StateMachine.sol";

contract testSM {

  StateMachine sm = StateMachine(DeployedAddresses.StateMachine());

  uint expectedConstructorState = 1;
  uint expectedEndState = 0;
  uint expectedInitState = 1;
  uint expectedLoadState = 2;
  uint expectedPlayState = 3;
  uint expectedStopState = 4;
  uint expectedUnloadeState =5;
  
  address expectedAdress = address(this);

  function testConstructorState() public
    {
      uint returnedState = uint(sm.getState());
      Assert.equal(returnedState, expectedConstructorState, "when deployed State Machine should be turned on .");
    }

function testEndState() public
{
	sm.end();
	uint returnedState = uint(sm.getState());
	Assert.equal(returnedState, expectedEndState,'when started it can be turned off');
}

function testInitState() public
{
	sm.init();
	uint returnedState = uint(sm.getState());
	Assert.equal(returnedState, expectedInitState, 'when is off it can be turned on');
}

 function testLoadState() public
 {
   sm.load();
   uint returnedState = uint(sm.getState());
   Assert.equal(returnedState, expectedLoadState, 'when turned on it can be load');   
 }

 function testPlayState() public
 {
   sm.play();
   uint returnedState = uint(sm.getState());
   Assert.equal(returnedState, expectedPlayState, 'when loaded it can be play');
 }

 
}
