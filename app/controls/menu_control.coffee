class MenuControl

  BACKGROUND_SPEED = 1

  constructor: (game) ->
    @game = game
    @sidescrollerState = require '../states/sidescroller_state'
    @birdseye_state = require '../states/birdseye_state'

  nextMove: ->
    @checkForStateChange()
    @moveBackground()

  checkForStateChange: ->
    if @game.input.pressed("enter")
      @game.switchState @sidescrollerState
    if @game.input.pressed("backspace")
      @game.switchState @birdseye_state

  moveBackground: ->
    return true

module.exports = MenuControl
