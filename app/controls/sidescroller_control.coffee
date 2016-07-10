class SidescrollerControl

  X_SPEED = 5
  Y_SPEED = 5
  BG_SPEED = 1
  GRAVITY = 1
  LIFT = 1.5

  constructor: (game, viewport) ->
    @game = game
    @viewport = viewport
    @menuState = require '../states/menu_state'
    @birdseyeState = require '../states/birdseye_state'

  nextMove: ->
    console.log @game.player.rect()
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
    # each background entity traverses the view in 30 steps over 0.5s, 2s, or 4s
    # the constant on the end gets the right number of pixels for each of the 30 steps.
    waterPosition = (@game.loop.currentTick % 500) * 1.6 - 400
    treePosition = (@game.loop.currentTick % 2000) * 0.4 - 400
    rockPosition = (@game.loop.currentTick % 4000) * 0.2 - 400

    waterVerticalAcc = 0.1 * ((@game.loop.currentTick % 300) - 150)

    for i in [1...2]
      water = @game.waterFactory.deploy()
      water.moveTo(@game.player.rect().x + waterPosition, 400)
      @viewport.add [water]

  moveWater: ->



module.exports = SidescrollerControl
