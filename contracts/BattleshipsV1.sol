pragma solidity ^0.4.19;

import './Battleships.sol';


contract BattleshipsV1 is Battleships {

    mapping(address => address) private opponents;
    mapping(address => uint8[][]) private boards;

    enum shipTypes { Tug, Frigate, Destroyer, Battleship, Carrier }

    uint8[8][8] private defaultBoard;

    function BattleshipsV1()
        public
    {

    }

    function playTurn(uint8 x, uint8 y)
        external
    {
        address player = msg.sender;
        address opponent = opponents[player];
        uint8 result = 0; // TODO: Calculate this
        uint8 hitsPercentage = 0; // TODO: Calculate this
        uint8 shipId = 10; // TODO: Get it from somewhere?

        if (result != 0 && hitsPercentage > 50) {
            // TODO: remove from board
            ShipSunk(player, opponent, shipId);
        }
        TurnPlayed(player, opponent, x, y, result);
    }
}
