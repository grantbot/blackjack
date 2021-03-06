# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'playerWinTally', 0
    @set 'dealerWinTally', 0

    @get('playerHand').on 'stand', => @get('dealerHand').dealerPlay()

    @get('dealerHand').on 'stand', => @compareScoresBelow21()


    #Refactor to use event listeners that detect which hand triggered the event
    @get('dealerHand').on 'blackjack', => @dealerWins()
    @get('playerHand').on 'blackjack', => @playerWins()

    @get('dealerHand').on 'bust', => @playerWins()
    @get('playerHand').on 'bust', => @dealerWins()


  compareScoresBelow21: ->
    console.log("DEALER STANDS")
    playerScores = @get('playerHand').scores()
    dealerScores = @get('dealerHand').scores()

    playerScore = if Math.max(playerScores[0], playerScores[1]) < 21 then Math.max(playerScores[0], playerScores[1]) else Math.min(playerScores[0], playerScores[1])
    dealerScore = if Math.max(dealerScores[0], dealerScores[1]) < 21 then Math.max(dealerScores[0], dealerScores[1]) else Math.min(dealerScores[0], dealerScores[1])
    console.log("playerScore: " + playerScore)
    console.log("dealerScore: " + dealerScore)

    if playerScore == dealerScore
      @tie()
    else if playerScore > dealerScore
      @playerWins()
    else
      @dealerWins()


  tie: ->
    alert("TIE")
    setTimeout(@resetGame.bind(this), 1000)
    #Reset
  playerWins: ->
    alert("PLAYER WINS")
    @set 'playerWinTally', @get('playerWinTally')+1
    setTimeout(@resetGame.bind(this), 1000)


  dealerWins: ->
    alert("DEALER WINS")
    @set 'dealerWinTally', @get('dealerWinTally')+1
    setTimeout(@resetGame.bind(this), 1000)

  resetGame: ->
    @get('playerHand').reset()

    @get('playerHand').hit()
    @get('playerHand').hit()


    @get('dealerHand').reset()

    @get('dealerHand').hit()
    @get('dealerHand').hit()


  # Player and Dealer blackjack heard
    # tie, call compareScores function



    #
    # if player 1 > dealer
        # call playerWin()

    # playerWin()



  # playerWin ->

  # Score ->
