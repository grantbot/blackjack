class window.Hand extends Backbone.Collection
  model: Card

  initialize: (initialHand, @deck, @isDealer) ->

    @.on 'add', => @checkOutcome()
    self = @
    # Another way to get @scores to fire after the cards are saved,
    # instead of calling it outside in Deck model
    # setTimeout(=>
    #   console.log("INSIDE", @scores())
    # , 0)

    # @checkOutcome() - card models not added by this point

  hit: ->
    @add(@deck.pop())

  stand: ->
    @trigger('stand')

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # debugger
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  checkOutcome: ->
    scores = @scores()
    @hasBlackjack(scores)
    @hasBust(scores)

  hasBust: (scores) ->
    if Math.min(scores[0], scores[1]) > 21 then @trigger('bust', this)
    # Reset board

  hasBlackjack: (scores) ->
    if scores[0] is 21 or scores[1] is 21 then @trigger('blackjack', this)
    # Reset board

  dealerPlay: ->
    @models[0].set('revealed', true)
    # Dealer should stand on soft 17s (e.g. 17 = 6 + Ace (high)) as well
    while @scores()[0] < 17
      console.log(@scores()[0])
      @hit()

    if Math.min(@scores()[0], @scores()[1]) <= 21 then @trigger('stand')


