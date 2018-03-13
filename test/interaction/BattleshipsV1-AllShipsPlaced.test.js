const { expect } = require("chai")
const BattleshipsV1 = artifacts.require("./BattleshipsV1.sol")

const Zero = require("../utils/zero")
const { getLog } = require("../utils/txHelpers")
const assertThrows = require("../utils/assertThrows")
// const checkShipsNotPlaced = require('../utils/checkShipsNotPlaced')

contract("BattleshipsV1 all ships placed", ([player, opponent]) => {
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
    // tx = await battleships.placeShip(x, y, ship, direction)
    // tx = await battleships.placeShip(x, y, ship, direction)
    // ..

    // tx = await battleships.placeShip(x, y, ship, direction, { from: opponent })
    // tx = await battleships.placeShip(x, y, ship, direction, { from: opponent })
    // tx = await battleships.placeShip(x, y, ship, direction, { from: opponent })
    // ..
  })

  context("trying to play another ship", () => {
    it("player can't play another ship", () =>
      assertThrows(battleships.placeShip(x, y, ship, direction)))

    it("opponent can't play another ship", () =>
      assertThrows(
        battleships.placeShip(x, y, ship, direction, { from: opponent })
      ))
  })

  // ;[1, 2, 3, 4, 5].forEach(checkShipsAllPlaced)

  xcontext("opponent tries to play a shot out of turn", () => {
    it("throws an error", () =>
      assertThrows(battleships.playTurn(1, 1, { from: opponent })))
  })

  context("player plays a turn", () => {
    before(async () => {
      tx = await battleships.playTurn(1, 1)
    })

    it("emitted the TurnPlayed event", () => {
      expect(getLog(tx, "TurnPlayed")).to.exist
    })

    it("now it is the opponent's turn", async () => {
      expect(await battleships.whoseTurn()).to.equal(opponent)
    })
  })
})
