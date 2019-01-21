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


  //helper
  function run(string memory s)public returns(bool){
   (bool b, ) = address(sm).call(abi.encodeWithSignature(s));
   return b;
 }
  
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
 Assert.isFalse(run("init()"),"when off you can't turned off again");
 }

 function testNoPlayFromInit() public {
   
   Assert.isFalse(run("play()"),"you can't play without load first");

 }

 function testNoStopFromInit() public{
   
   Assert.isFalse(run("stop()"), "you can't stop from init");
 }


 function testNoUnloadFromInit() public{

   Assert.isFalse(run("unload()"), "you can't stop from init");
 }
 //end init restrictions

 //begin load restriction
 


 function testNoInitFromLoaded() public{
  sm.load();
   
      Assert.isFalse(run("init()"), "It went from loaded to Init");                                          }

 
 function testNoLoadedAgain() public{
   
      Assert.isFalse(run("load()"), "It went from loaded to loaded");
 }
 
 function testNoStopFromLoaded() public{
   
   Assert.isFalse(run("stop()"), "It went from loaded to stoped");
 }


 function testNoEndFromLoaded() public{
   
   Assert.isFalse(run("end()"), "It went from loaded to  off");
 }
  
 //end load restrictions

 //begin play restictions

 
 function testNoInitFromPlaying() public{
   sm.play();
   Assert.isFalse(run("play()"), "It went from playing to init");

 }


 function testNoPlayingAgain() public{
   Assert.isFalse(run("play()"), "It went from playing to playing");

 }

 
 function testNoLoadFromPlaying() public{
   Assert.isFalse(run("load()"), "It went fromplaying to load");

 }

 function testNoUnloadFromPlaying() public{
   Assert.isFalse(run("unload()"), "It went from playing to Unload");

 }

 function testNoEndFromPlaying() public{
   Assert.isFalse(run("end()"), "It went from playing to Off");

 }
 
 //end play restrictions

 //begin stop restrictions

 function testNoStopAgain() public{
   sm.stop();
   Assert.isFalse(run("stop()"), "It went fromStoped to Stoped");

 }

 function testNoInitFromStoped() public{
   Assert.isFalse(run("init()"), "It went from Stoped to On");

 }

 function testNoLoadFromStoped() public{
   Assert.isFalse(run("load()"), "It went from stoped to loaded");

 }

 function testNoEndFromStoped() public{
   Assert.isFalse(run("end()"), "It went from\
 stoped to Off");

 }

 //end stop restrictions
 
 //begin unload restrictions

 function testNoUnloadAgain() public{               sm.unload();
   Assert.isFalse(run("unload()"), "It went from Unloaded to Unloaded");

 }

function testNoInitFromUnload() public{            
   Assert.isFalse(run("init()"), "It went from Unload to On");

 }


 function testNoPlayFromUnload() public{
   Assert.isFalse(run("play()"), "It went from  Unload to playing");

 }


 function testNoStopFromUnload() public{
   Assert.isFalse(run("stop()"), "It went from Unload to Stoped");

 }


 
 //end unload restrictions
 
}//test end
