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

  //end smoke test
  
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

//end exterior loop

//begin happy path
 
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


 function testStop() public
 {
   sm.stop();
   uint returnedState = uint(sm.getState());
   Assert.equal(returnedState, expectedStopState, 'when playing it can be stoped');
 }

 function testUnload() public
 {
   sm.unload();
   uint returnedState = uint(sm.getState());
   Assert.equal(returnedState, expectedUnloadeState, 'when stoped it can be unload');
 }

 function testEnd() public
 {
   sm.end();
   uint returnedState = uint(sm.getState());
   Assert.equal(returnedState, expectedEndState, 'when stoped it can be turned off');
 }
 //end happy path
 
}
