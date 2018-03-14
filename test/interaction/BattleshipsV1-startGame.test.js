const { expect } = require('chai')
const BattleshipsV1 = artifacts.require('./BattleshipsV1.sol')

const Zero = require('../utils/zero')
// const checkShipsNotPlaced = require('../utils/checkShipsNotPlaced')

contract('BattleshipsV1 Start Game', ([player, opponent, nonplayer]) => {
  let battleships
  let tx

  before(async () => {
    battleships = await BattleshipsV1.new()
    tx = await battleships.startGame(opponent)
  })

  it("player has opponent 'opponent'", async () => {
    expect(await battleships.getOpponent()).to.equal(opponent)
  })

  it("opponent has opponent 'player'", async () => {
    expect(await battleships.getOpponent({ from: opponent })).to.equal(player)
  })

  it('nonplayer has no opponent', async () => {
    expect(await battleships.getOpponent({ from: nonplayer })).to.equal(
      Zero.address
    )
  })

  it("whoseTurn returns 'player'", async () => {
    expect(await battleships.whoseTurn()).to.equal(player)
  })

  it('isGameOver returns false', async () => {
    expect(await battleships.isGameOver()).to.be.false
  })

  // ;[1, 2, 3, 4, 5].forEach(checkShipsNotPlaced)
})
