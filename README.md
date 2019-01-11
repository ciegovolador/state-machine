
### An state machine for playing imaginary music on smart contracts


The aim of this code is to learn solidity and try the state machine pattern.

The idea behind this is to find a coding style that can reduce security risk an facilite formal analysis to eventualy be used on ricardian contracts and automatic behavior composing.


S = {ended, inited, loaded, playing, stoped, unloaded};

T = {
    {	ended, inited	},
    {	inited, ended	},
    {	inited, loaded	},
    {	loaded, unloaded},
    {	loaded, playing	},
    {	playing, stoped	},
    {	stoped, playing	},
    {	stoped, unloaded},
    {	unloaded, loaded},
    {	unloaded,endeded}
    }



V = {0,1, 2, 3, 4, 5};

E = {
    {0, 1},
    {1, 0},
    {1, 2},
    {2, 5},
    {2, 3},
    {3, 4},
    {4, 3},
    {4, 5},
    {5, 0}
    }
