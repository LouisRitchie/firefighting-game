class SidescrollerControl

  X_SPEED = 5
  Y_SPEED = 5
  BG_SPEED = 1

  constructor: (game, viewport) ->
    @game = game
    @viewport = viewport
    @menuState = require '../states/menu_state'
    @birdseyeState = require '../states/birdseye_state'

  nextMove: ->
    @checkForStateChange()
    @movePlayer()
    @moveBackground()
    @spawnWater()

  checkForStateChange: ->
    if @game.input.pressed("escape")
      @game.switchState @menuState
    if @game.input.pressed("enter")
      @game.switchState @birdseyeState

  movePlayer: ->
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

    @game.player.move(xSpeed, ySpeed)

  moveBackground: ->

  spawnWater: ->
    for i in [1...20]
      water = @game.waterFactory.deploy()
      x = 100 * ( i % 3 ) * ( i % 7 )
      y = 150 * ( i % 10 )
      @viewport.add [water]
      water.moveTo(x, y)


module.exports = SidescrollerControl
