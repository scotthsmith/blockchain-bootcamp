const { expect } = require("chai")
const BattleshipsV1 = artifacts.require("./BattleshipsV1.sol")

const Zero = require("../utils/zero")
const { getLog } = require("../utils/txHelpers")
const assertThrows = require("../utils/assertThrows")
// const checkShipsNotPlaced = require('../utils/checkShipsNotPlaced')

contract("BattleshipsV1 placeShip", ([player, opponent, nonplayer]) => {
  let battleships
  let tx
  const x = 3
  const y = 3
  const ship = 3
  const direction = 0

  before(async () => {
    battleships = await BattleshipsV1.new()
    await battleships.startGame(opponent)
    // tx = await battleships.placeShip(x, y, ship, direction)
  })

  xit("ShipPlaced event was emitted", () => {
    expect(getLog(tx, "ShipPlaced")).to.be.ok
  })

  xit("whoseTurn returns 'player'", () => {
    expect(battleships.whoseTurn()).to.equal(player)
  })

  xit("isGameOver returns false", () => {
    expect(battleships.isGameOver()).to.be.false
  })

  xdescribe("cells are as expected", () => {
    it("getCell(3, 2) returns 0", () => {
      expect(battleships.getCell(x, y)).to.equal(0)
    })

    it("getCell(3, 3) returns 3", () => {
      expect(battleships.getCell(x, y)).to.equal(ship)
    })

    it("getCell(3, 4) returns 3", () => {
      expect(battleships.getCell(x, y)).to.equal(ship)
    })

    it("getCell(3, 5) returns 3", () => {
      expect(battleships.getCell(x, y)).to.equal(ship)
    })

    xit("getCell(3, 6) returns 3", () => {
      expect(battleships.getCell(x, y)).to.equal(ship)
    })
  })

  describe("placing a second ship", () => {
    const x2 = 5
    const y2 = 3
    const ship2 = 1
    const direction2 = 1

    before(async () => {
      // tx = await battleships.placeShip(x2, y2, ship2, direction2)
    })

    xit("ShipPlaced event was emitted", () => {
      expect(getLog(tx, "ShipPlaced")).to.be.ok
    })

    it("Can't place overlapping ship", () =>
      assertThrows(battleships.placeShip(x2, y2, 2, direction2)))

    it("Can't place ship out of bounds", () =>
      assertThrows(battleships.placeShip(8, 8, 4, 0)))

    it("Can't place ship that stretches to out of bounds", () =>
      assertThrows(battleships.placeShip(5, 5, 4, 0)))

    describe("opponent can place a ship", () => {
      before(async () => {
        // tx = await battleships.placeShip(x2, y2, ship2, direction2, { from: opponent })
      })

      xit("ShipPlaced event was emitted", () => {
        expect(getLog(tx, "ShipPlaced")).to.be.ok
      })

      xit("player can't play a turn", () =>
        assertThrows(battleships.playTurn(5, 5)))

      xit("opponent can't play a turn", () =>
        assertThrows(battleships.playTurn(5, 5, { from: opponent })))
    })
  })

  describe("nonplayer", () => {
    it("can't place a ship", () =>
      assertThrows(battleships.placeShip(1, 1, 1, 1, { from: nonplayer })))

    xit("can't play a turn", () =>
      assertThrows(battleships.playTurn(1, 1, { from: nonplayer })))
  })

  // ;[1, 2, 3, 4, 5].forEach(checkShipsNotPlaced)
})
