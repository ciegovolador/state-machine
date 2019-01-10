pragma solidity 0.5.0;

contract StateMachine {

enum State {inited, loaded,  playing,  paused, unloaded, stoped, ended}

State state;

constructor() public {
state = State.inited;
}

function _setState( State _state) private returns (bool)
{
require(uint(_state) <= uint(State.ended),'codigo incorrecto');
state = _state;

return true;

}

function getState() view public returns(State){

return state;


}

function end() public returns (bool) 
{
require(state != State.ended,'machine is turn off');
require(state != State.playing,'machine is playing, stop before turn off');

return _setState(State.ended);


}

function init() public returns (bool)
{
require(state == State.ended,'machine is running');
return _setState(State.inited);

}

function play() public returns (bool)
{
require(state != State.playing,'machine is playing');
require( state != State.ended, 'machine is off, turn on first');
_setState(State.playing);
return true;
}

function stop() public returns(bool)

{
require(state != State.ended, 'machine is turned off');
require( state == State.playing , 'Machine is not playing');

_setState(State.stoped);

}



}
