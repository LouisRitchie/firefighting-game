class SidescrollerControl

  X_SPEED = 5
  Y_SPEED = 5
  BG_SPEED = 1
  GRAVITY = 1
  LIFT = 1.5

  constructor: (game, viewport) ->
    # anything that has '@' in front will be stored in game.oldState automatically.
    # access game.oldState here to access those '@' variables from last time.
    @game = game
    @viewport = viewport
    @menuState = require '../states/menu_state'
    @birdseyeState = require '../states/birdseye_state'

  nextMove: ->
    @checkForStateChange()
    @addAcceleration()
    @movePlayer()
    @moveBackground()
    @moveWater()

  checkForStateChange: ->
    if @game.input.pressed("escape")
      @game.switchState @menuState
    if @game.input.pressed("enter")
      @game.switchState @birdseyeState

  addAcceleration: ->

  movePlayer: ->
    xSpeed = X_SPEED
    ySpeed = 0
    @game.player.acc[1] += GRAVITY if @game.player.acc[1] <=1.0

    if @game.input.pressed("right")
      xSpeed = X_SPEED
    if @game.input.pressed("left")
      xSpeed = X_SPEED
    if @game.input.pressed("up")
      @game.player.acc[1] -= LIFT
    if @game.input.pressed("down")
      ySpeed = Y_SPEED

    @game.player.move(xSpeed, ySpeed)

  moveBackground: ->

  moveWater: ->



module.exports = SidescrollerControl
