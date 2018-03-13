const { expect } = require("chai")
const BattleshipsV1 = artifacts.require("./BattleshipsV1.sol")

const Zero = require("../utils/zero")
const { getLog } = require("../utils/txHelpers")
const assertThrows = require("../utils/assertThrows")
// const checkShipsNotPlaced = require('../utils/checkShipsNotPlaced')

contract("BattleshipsV1 game over", ([player, opponent]) => {
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

    // tx = await battleships.playTurn(x, y)
    // tx = await battleships.playTurn(x, y, { from: opponent })
    // tx = await battleships.playTurn(x, y)
    // tx = await battleships.playTurn(x, y, { from: opponent })
    // ..
  })

  xit("emitted the GameOver event", () => {
    expect(getLog(tx, "GameOver")).to.exist
  })

  xit("isGameOver is true for player", async () => {
    expect(await battleships.isGameOver()).to.be.true
  })

  xit("isGameOver is true for opponent", async () => {
    expect(await battleships.isGameOver({ from: opponent })).to.be.true
  })

  xit("whoseTurn returns 0x0", async () => {
    expect(await battleships.whoseTurn()).to.equal(Zero.address)
  })

  xit("player has no opponent", async () => {
    expect(await battleships.getOpponent()).to.equal(Zero.address)
  })

  xit("opponent has no opponent", async () => {
    expect(await battleships.getOpponent({ from: opponent })).to.equal(
      Zero.address
    )
  })
})
