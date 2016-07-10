class menuControl
  constructor: (game) ->
    @game = game
    return @

  nextState: (nextState) ->
    console.log "[menu_control] [nextState] nextState"
    console.log nextState
    @nextState = nextState

  respondToInput: ->
    if @game.input.pressed("enter")
      console.log "[menu_control] logging nextState: "
      console.log @nextState
      @game.switchState @nextState

module.exports = menuControl
