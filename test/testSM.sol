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
      Assert.equal( returnedState, expectedConstructorState, 'when deployed State Machine should be turned on .');
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

 //testing restrictions
 //init restriction

 function testNoInitAgain() public {
   sm.init();
   (bool b, ) =  address(sm).call(abi.encodeWithSignature("init()"));
   Assert.isFalse(b,"when off you can't turned off again");
 }


 function testNoPlayFromInit() public {
   //   sm.init();
   (bool b, ) = address(sm).call(abi.encodeWithSignature("play()"));
   Assert.isFalse(b,"you can't play without load first");

 }

 function testNoStopFromInit() public{
   (bool b, ) = address(sm).call(abi.encodeWithSignature("stop()"));
   Assert.isFalse(b, "you can't stop from init");
 }


 function testNoUnloadFromInit() public{
   (bool b, ) = address(sm).call(abi.encodeWithSignature("unload()"));                              Assert.isFalse(b, "you can't stop from init");
 }
 //end init restrictions

 //begin load restriction
 


 function testNoInitFromLoaded() public{
  sm.load();
   (bool b, ) = address(sm).call(abi.encodeWithSignature("init()"));                        
      Assert.isFalse(b, "It went from loaded to Init");                                          }

 
 function testNoLoadedAgain() public{
   (bool b, ) = address(sm).call(abi.encodeWithSignature("load()"));
      Assert.isFalse(b, "It went from loaded to loaded");
 }
 
 function testNoStopFromLoaded() public{
   (bool b, ) = address(sm).call(abi.encodeWithSignature("stop()"));
   Assert.isFalse(b, "It went from loaded to stoped");
 }


 function testNoEndFromLoaded() public{
   (bool b, ) = address(sm).call(abi.encodeWithSignature("end()"));
   Assert.isFalse(b, "It went from loaded to  off");
 }
  
 //end load restrictions

 //begin play restictions

 function run(string memory s)public returns(bool){
   (bool b, ) = address(sm).call(abi.encodeWithSignature(s));
   return b;
 }
 
 function testNoInitFromPlaying() public{
   sm.play();
   Assert.isFalse(run("play()"), "It went from playing to init");

 }

 
 //end play restrictions

 //begin stop restrictions

 //end stop restrictions

 //begin unload restrictions

 //end unload restrictions
 
}//test end
