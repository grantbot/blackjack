class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    # console.log(@collection)
    @collection.on 'add remove change', => @render()

    @render()

    #Refactor these to distinguish between player and dealer
    @collection.on 'blackjack', (playerOrDealer) => console.log(playerOrDealer)
    @collection.on 'bust', (playerOrDealer) => console.log(playerOrDealer)

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.scores()[0]


