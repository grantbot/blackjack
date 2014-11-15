assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()
    dealerHand = deck.dealDealer()

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 50
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.length, 49

  describe 'blackjack', ->
    it 'should recognize a blackjack hand', ->
      blackjackHand = new Hand [{rank: 10, suit: 'Hearts'}, {rank: 1, suit: 'Hearts'}], @
