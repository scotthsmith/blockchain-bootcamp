pragma solidity ^0.4.19;

import './Battleships.sol';


contract BattleshipsV1 is Battleships {

    mapping(address => address) private opponents;
    mapping(address => uint8[][]) private boards;
    mapping(address => bool) private currentPlayer;
    mapping(address => uint8) private gameState;

    enum ShipTypes { Empty, Tug, Frigate, Destroyer, Battleship, Carrier }
    uint8[8][8] private defaultBoard;

    struct ShipInfo {
        uint8 width;
        uint8 depth;
        uint8 count;
    }

    ShipInfo[] private defaultShips;

    modifier notAlreadyPlaying(address player) {
        require(opponents[player] == address(0));
        _;

    }

    function BattleshipsV1()
        public
    {
        // Initialise the default ships structure
        defaultShips.push(ShipInfo(0, 0, 0));
        defaultShips.push(ShipInfo(1, 1, 1));
        defaultShips.push(ShipInfo(1, 2, 2));
        defaultShips.push(ShipInfo(1, 3, 2));
        defaultShips.push(ShipInfo(1, 4, 2));
        defaultShips.push(ShipInfo(2, 5, 1));
    }

    /**
     * Starts a new game between `msg.sender` and the nominated opponent.
     * MUST emit the `GameStarted` event.
     * @param opponent The address you are playing against.
     */
    function startGame(address opponent)
        external
        notAlreadyPlaying(msg.sender)
        notAlreadyPlaying(opponent)
    {
        address player = msg.sender;
        opponents[player] = opponent;
        opponents[opponent] = player;

        clearBoard(player);
        clearBoard(opponent);

        currentPlayer[player] = true;
        currentPlayer[opponent] = true;
        gameState[player] = 1;
        gameState[opponent] = 1;

        GameStarted(player, opponent);

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
     * placed one at a time until there are no more ships.
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

        ShipInfo memory thisShip = defaultShips[ship];

        if (direction == 0) {
            for (uint8 idxX = x; idxX < (x + thisShip.width); idxX++) {
                for (uint8 idxY = y; idxY < (y + thisShip.depth); idxY++) {
                    assert(boards[player][idxX][idxY] == uint8(ShipTypes.Empty));
                    boards[player][idxX][idxY] = ship;
                }
            }

        } else {
            for (idxX = x; idxX < (x + thisShip.depth); idxX++) {
                for (idxY = y; idxY < (y + thisShip.width); idxY++) {
                    assert(boards[player][idxX][idxY] == uint8(ShipTypes.Empty));
                    boards[player][idxX][idxY] = ship;
                }
            }

        }

        ShipPlaced(player, x, y, ship, direction);
    }

    /**
     * A shot is fired.
     * MUST emit `TurnPlayed` event with the result of the shot.
     * Results are either `0` for a miss, or the int8 representing the ship type that was hit.
     * If a hits on a ship account for more than 50% of its size then it is sunk.
     * A negative number denotes that part of the ship was hit.
     * If a ship is sunk then the ship is removed from the board emit a `ShipSunk` event.
     * @param x The horizontal grid location of the shot.
     * @param y The vertical grid location of the shot.
     */
    function playTurn(uint8 x, uint8 y)
        external
    {
        address player = msg.sender;
        address opponent = opponents[player];
        assert(gameState[player] == 2);
        assert(gameState[opponent] == 2);
        uint8 result = 0; // TODO: Calculate this
        uint8 hitsPercentage = 0; // TODO: Calculate this
        uint8 shipId = 10; // TODO: Get it from somewhere?

        if (result != 0 && hitsPercentage > 50) {
            // TODO: remove from board
            ShipSunk(player, opponent, shipId);
        }

        currentPlayer[player] = false;
        currentPlayer[opponent] = true;

        TurnPlayed(player, opponent, x, y, result);
    }

    /**
     * gets your opponent's address
     * @return the address of your current opponent. Returns 0x0 if youare not playing.
     */
    function getOpponent()
        external
        view
        returns (address)
    {
        return opponents[msg.sender];
    }

    /**
     * Get the current content of the nominated cell for the player.
     * Results are either `0` for nothing, or the uint8 representing the ship type.
     * If a hits on a ship account for more than 50% of its size then it is sunk
     * and the ship is removed from the board. If this happens emit a `ShipSunk` event.
     * @param x The horizontal grid location of the player's grid cell.
     * @param y The vertical grid location of the player's grid cell.
     */
    function getCell(uint8 x, uint8 y)
        external
        view
        returns (uint8)
    {
        return boards[msg.sender][x][y];
    }

    /**
     * Have all of the ships of the given type been placed?
     * @param shipType The type of ship you are checking on, or if 0 it checks all ship types.
     * @return true if all the ships of the given type have been placed.
     *
     *   | Type       | size  | count | sum
     * 1 | Tug        | 1 x 1 | 1     | 1
     * 2 | Frigate    | 1 x 2 | 2     | 4
     * 3 | Destroyer  | 1 x 3 | 2     | 6
     * 4 | Battleship | 1 x 4 | 2     | 8
     * 5 | Carrier    | 2 x 5 | 1     | 10
     *     Total                        29
     */
    function allShipsPlaced(uint8 shipType)
        external
        view
        returns (bool)
    {
        /* All cells will have to checked anyone, so front load that work. */
        uint8[6] memory expectedCounts = [29, 1, 4, 6, 8, 10];
        uint8[6] memory cellCounts;
        for (uint8 x = 0; x < 8; ++x) {
            for (uint8 y = 0; y < 8; ++y) {
                uint8 cellType = boards[msg.sender][x][y];
                if (cellType != 0) {
                    cellCounts[cellType] += 1;
                    cellCounts[0] += 1;
                }
            }
        }
        if (cellCounts[shipType] == expectedCounts[shipType]) {
            gameState[msg.sender] = 2;
            gameState[opponents[msg.sender]] = 2;
            return true;
        }
        return false;
    }

    /**
     * The address of the player whose turn it is.
     * @return the current player's address.
     */
    function whoseTurn()
        external
        view
        returns (address)
    {
        if (currentPlayer[msg.sender]) {
            return msg.sender;
        } else {
            return opponents[msg.sender];
        }
    }

    /**
     * Check if the game is still going.
     * @return true if the one of the players has no remaining ships.
     */
    function isGameOver()
        external
        view
        returns (bool)
    {
        //if (isBoardCleared(msg.sender) && isBoardCleared(opponents[msg.sender])) {
        //if game started && all ships placed && one board is cleared(?) - gameover


        if (isGameStarted(msg.sender) || isGameStarted(opponents[msg.sender])) {
            //Game has started
            if (isBoardCleared(msg.sender) && isBoardCleared(opponents[msg.sender])) {
                //Game has started but boards are empty
                return false;
            } else if (isBoardCleared(msg.sender) && gameState[msg.sender] == 2) {
                endGame(msg.sender, opponents[msg.sender]);
                return true;
            } else if (isBoardCleared(opponents[msg.sender]) && gameState[opponents[msg.sender]] == 2) {
                endGame(msg.sender, msg.sender);
                return true;
            } else {
                return false;
            }
        } else {
            //Game has not been started
            return false;
        }
    }

    /**
     * Check if a players board has been cleared
     * @return true if the player has no remaining ships
     */
    function isBoardCleared(address player)
        internal
        view
        returns(bool)
    {
        for (uint8 x = 0; x < 8; x++) {
            for (uint8 y = 0; y < 8; y++) {
                uint8 cellType = boards[player][x][y];
                if (cellType > 0) {
                    return false;
                }
            }
        }
        return true;
    }

    /**
     * Check if game has been started
     * @return false if the game has not been started, true otherwise
     */
    function isGameStarted(address player)
        internal
        view
        returns(bool)
    {
        if (gameState[player] == 0) {
            return false;
        } else {
            return true;
        }
    }

    /**
     * Set gameState to ended
     */
    function endGame(address player, address winner)
        internal
    {
        gameState[player] = 0;
        gameState[opponents[player]] = 0;
        opponents[player] = address(0);
        GameEnded(player, opponents[player], winner);
    }

    /*
     * Clear the player's board
     */
    function clearBoard(address player)
        internal
    {
        boards[player].length = 0;
        uint8[] memory line = new uint8[](8);
        for (uint8 x = 0; x < 8; x++) {
            boards[player].push(line);
        }
    }
}
