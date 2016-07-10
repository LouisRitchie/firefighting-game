class sidescrollerControl

  X_SPEED = 5
  Y_SPEED = 5
  BG_SPEED = 1

  constructor: (game) ->
    @game = game
    @player = game.player
    @bg1 = game.bg1
    @bg2 = game.bg2
    @menuState = require '../states/menu_state'

  nextMove: ->
    @checkForStateChange()
    @moveBackground()
    xSpeed = X_SPEED
    ySpeed = Y_SPEED

    if @game.input.pressed("right")
      xSpeed = X_SPEED * 1.4
    if @game.input.pressed("left")
      xSpeed = X_SPEED * 0.6
    if @game.input.pressed("up")
      ySpeed = -Y_SPEED * 0.5
    if @game.input.pressed("down")
      ySpeed = Y_SPEED * 2

    @player.move(xSpeed, ySpeed)

  checkForStateChange: ->
    if @game.input.pressed("escape")
      @game.switchState @menuState

  moveBackground: ->

module.exports = sidescrollerControl
