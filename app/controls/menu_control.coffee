class menuControl

  BACKGROUND_SPEED = 1

  constructor: (game) ->
    @game = game
    @sidescrollerState = require '../states/sidescroller_state'

  nextMove: ->
    @checkForStateChange()
    @moveBackground()

  checkForStateChange: ->
    if @game.input.pressed("enter")
      @game.switchState @sidescrollerState

  moveBackground: ->
    return true;

module.exports = menuControl
