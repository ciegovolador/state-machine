pragma solidity 0.5.0;

contract StateMachine {

enum State {off, on, loaded,  playing, stoped, unloaded}

State state;

constructor() public
{
	state = State.on;
}

function _setState( State _state) private
{
	state = _state;
}

function getState() view public returns(State)
{
	return state;
}

function notAtOff() private view
{
	require(state != State.off, 'machine is turn off');
}

function atOff() private view
{
	require(state == State.off, 'machine× is turned on');
}

 function atOn() private view{
   require(state == State.on, 'Machine is not at init');
 }

 function notAtOn() private view{
   require(state != State.on, 'Macine in at Init');
 }

function notAtLoaded() private view
{
	require(state != State.loaded,'machine is loaded');
}

 function atLoaded() private view{
   require( state == State.loaded, 'Machine is not loaded');
 }

function notAtPlaying() private view
{
	require(state != State.playing, 'machine is playing');
}

function atPlaying() private view
{
	require(state == State.playing, 'machine is not playing');
}

 function atStoped() private view
 {
   require(state == State.stoped, 'Machine is Not  Stoped');
 }

 function notAtStoped() private view
 {
   require(state != State.stoped, 'Machine is Stoped');
 }

 function notAtUnloaded() private view
{
	require(state != State.unloaded, 'machine is unloaded');
}


 function atUnloaded() public view{
   require(state == State.unloaded, 'Machine is not loaded');
 }
 
function end() public 
{
	notAtOff();
	notAtLoaded();
	notAtPlaying();
	notAtStoped();
	_setState(State.off);
}

function init() public
{
	atOff();
	_setState(State.on);
}

 function load() public
 {
   notAtOff();
   notAtLoaded();
   notAtPlaying();
   notAtStoped();
   _setState(State.loaded);
 }
 
function play() public
{
	notAtOff();
	notAtOn();
	notAtPlaying();
	notAtUnloaded();
	_setState(State.playing);
}

function stop() public
{	
	atPlaying();
	_setState(State.stoped);
}

 function unload() public
 {
   notAtOff();
   notAtOn();
   notAtPlaying();
   notAtUnloaded();
   _setState(State.unloaded);
 }

}
