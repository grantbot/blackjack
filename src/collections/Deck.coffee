class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    @add _([0...52]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)



  dealPlayer: ->
    a = new Hand [@pop(), @pop()], @
    a.checkOutcome()
    a


  dealDealer: ->
    b = new Hand [@pop().flip(), @pop()], @, true
    b.checkOutcome()
    b


