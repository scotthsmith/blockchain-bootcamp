const { expect } = require('chai')

const checkShipsNotPlaced = battleships => ship => {
  it(`has not placed all ships of type ${ship}`, async () => {
    expect(await battleships.allShipsPlaced()).to.be.false
  })
}

module.exports = checkShipsNotPlaced
