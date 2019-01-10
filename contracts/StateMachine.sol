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

function on() private view
{
	require(state != State.off, 'machine is turn off');
}

function off() private view
{
	require(state == State.off, 'machine× is turned on');
}

function noLoaded() private view
{
	require(state != State.loaded,'machine is loaded');
}

function noPlaying() private view
{
	require(state != State.playing, 'machine is plaing');
}

function Playing() private view
{
	require(state == State.playing, 'machine is not playing');
}
function noUnloaded() private view
{
	require(state != State.unloaded, 'machine is unloaded');
}

function end() public 
{
	on();
	noPlaying();
	_setState(State.off);
}

function init() public
{
	off();
	_setState(State.on);
}

function play() public
{
	on();
	noPlaying();
	noUnloaded();
	_setState(State.playing);
}

function stop() public
{
	
	Playing();
	_setState(State.stoped);

}


}
