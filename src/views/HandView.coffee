class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    # console.log(@collection)
    @collection.on 'add remove change', => @render()

    @render()
    @collection.on 'blackjack', => alert("blackjack yo")
    @collection.on 'bust', => alert("bitch you broke, shut up, don't talk to me")

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.scores()[0]

