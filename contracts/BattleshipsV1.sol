pragma solidity ^0.4.19;

import './Battleships.sol';


contract BattleshipsV1 is Battleships {


    mapping(address => address) private opponents;
    mapping(address => uint8[][]) private boards;

    enum ShipTypes { Tug, Frigate, Destroyer, Battleship, Carrier }


    uint8[8][8] private defaultBoard;

    struct ShipInfo {
        uint8 width;
        uint8 depth;
        uint8 count;
    }

    ShipInfo[] private defaultShips;

    function BattleshipsV1()
        public
    {
        // Initialise the default ships structure
        defaultShips[uint8(ShipTypes.Tug)] = ShipInfo(1, 1, 1);
        defaultShips[uint8(ShipTypes.Frigate)] = ShipInfo(1, 2, 2);
        defaultShips[uint8(ShipTypes.Destroyer)] = ShipInfo(1, 3, 2);
        defaultShips[uint8(ShipTypes.Battleship)] = ShipInfo(1, 4, 2);
        defaultShips[uint8(ShipTypes.Carrier)] = ShipInfo(2, 5, 1);
    }
    
    /**
     * At the start of the game each player must place their ships, one at a time.
     *
     * Ship Types
     *
     *   | Type       | size  | count
     * 1 | Tug        | 1 x 1 | 1
     * 2 | Frigate    | 1 x 2 | 2
     * 3 | Destroyer  | 1 x 3 | 2
     * 4 | Battleship | 1 x 4 | 2
     * 5 | Carrier    | 2 x 5 | 1
     *
     * The ships get placfunction placeShip(uint8 x, uint8 y, uint8 ship, uint8 direction)
     * externalised one at a time until there are no more ships.
     * The function MUST throw if the placed ship overlaps with another.
     *
     * @param x The horizontal grid location of the top-left corner of the ship.
     * @param y The vertical grid location of the top-left corner of the ship.
     * @param ship The type of ship.
     * @param direction The direction the ship is facing. (0 is down, 1 is across)
     */
    function placeShip(uint8 x, uint8 y, uint8 ship, uint8 direction)
        external
    {
        address player = msg.sender;

        uint8[][] memory board = boards[player];

        ShipInfo memory thisShip = defaultShips[ship];


        for (uint8 idxX = x; idxX < x+thisShip.width; idxX++) {
            board[idxX][y] = ship;
        }

        for (uint8 idxY = y; idxY < y+thisShip.depth; idxY++) {
            board[x][idxY] = ship;
        }

        ShipPlaced(player, x, y, ship);
    }


}