class SidescrollerControl

  X_SPEED = 5
  Y_SPEED = 5
  BG_SPEED = 1
  GRAVITY = 1
  LIFT = 1.5
  TANK = 0
  TANK_COEF = 0.0025
  FILL_RATE = 1

  constructor: (game, viewport) ->
    @game = game
    @viewport = viewport
    @menuState = require '../states/menu_state'
    @birdseyeState = require '../states/birdseye_state'

  nextMove: ->
    #console.log @game.player.rect()
    @checkForStateChange()
    @addAcceleration()
    @movePlayer()
    @spawnBackground()

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

    if @game.player.y >= 350 and TANK < 100
      if @game.input.pressed("left")
        TANK += FILL_RATE * 0.8
      else if @game.input.pressed("right")
        TANK += FILL_RATE * 1.2
      else
        TANK += FILL_RATE

    #console.log "TANK: " + TANK + ". MAX LIFT: " + (LIFT - (TANK_COEF*TANK))
    #console.log @game.player.y
    if @game.player.y > 425
      console.log "game over. back to menu"
      TANK = 0
      @game.switchState @menuState

    if @game.input.pressed("right")
      xSpeed = X_SPEED
    if @game.input.pressed("left")
      xSpeed = X_SPEED
    if @game.input.pressed("up")
      @game.player.acc[1] += -LIFT + (TANK_COEF*TANK)
    if @game.input.pressed("down")
      @game.player.acc[1] += LIFT + (TANK_COEF*TANK)

    @game.player.move(xSpeed, ySpeed)

  spawnBackground: ->
    # each background entity traverses the view in 30 steps over 0.5s, 2s, or 4s
    # the constant on the end gets the right number of pixels for each of the 30 steps.
    spawnWater = if @game.loop.currentTick % 3 == 0 then true else false
    spawnTree = if @game.loop.currentTick % 15 == 0 then true else false
    spawnRock = if @game.loop.currentTick % 17 == 0 then true else false

    if spawnWater
      water = @game.waterFactory.deploy()
      water.moveTo(@game.player.rect().x + 400, 400)
      @viewport.add [water]
    if spawnTree
      tree = @game.treeFactory.deploy()
      tree.moveTo(@game.player.rect().x + 400, 300)
      @viewport.add [tree]
    if spawnRock
      rock = @game.rockFactory.deploy()
      rock.moveTo(@game.player.rect().x + 400, 200)
      @viewport.add [rock]

module.exports = SidescrollerControl
