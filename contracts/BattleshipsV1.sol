pragma solidity ^0.4.19;

import './Battleships.sol';


contract BattleshipsV1 is Battleships {

    mapping(address => address) private opponents;
    mapping(address => uint8[][]) private boards;

    uint8[8][8] private defaultBoard;

    enum ShipTypes { Tug, Frigate, Destroyer, Battleship, Carrier }

    function BattleshipsV1()
    public
    {

    }

    modifier notAlreadyPlaying(address player) {
        require(opponents[player] == address(0));
        _;

    }

    function startGame(address opponent)
        external
        notAlreadyPlaying(msg.sender)
        notAlreadyPlaying(opponent)
    {
        address player = msg.sender;
        opponents[player] = opponent;
        opponents[opponent] = player;

        boards[player] = defaultBoard;
        boards[opponent] = defaultBoard;

        GameStarted(player, opponent);
    }

}