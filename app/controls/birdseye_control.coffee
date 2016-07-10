class BirdseyeControl

  X_SPEED = 5
  Y_SPEED = -7
  BG_SPEED = 1

  constructor: (game) ->
    @game = game
    @menuState = require '../states/menu_state'
    @sidescrollerState = require '../states/sidescroller_state'

  nextMove: ->
    @checkForStateChange()
    @moveBackground()
    xSpeed = 0
    ySpeed = Y_SPEED

    if @game.input.pressed("right")
      xSpeed = X_SPEED
    if @game.input.pressed("left")
      xSpeed = -X_SPEED
    if @game.input.pressed("up")
      ySpeed = Y_SPEED * 1.3
    if @game.input.pressed("down")
      ySpeed = Y_SPEED *  0.6

    @game.player.move(xSpeed, ySpeed)

  checkForStateChange: ->
    if @game.input.pressed("escape")
      @game.switchState @menuState
    if @game.input.pressed("enter")
      console.log "changing back to sidescroller..."
      @game.switchState @sidescrollerState

  moveBackground: ->

module.exports = BirdseyeControl
