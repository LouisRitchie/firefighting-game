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

    if @game.input.pressed("right")
      xSpeed = X_SPEED
    if @game.input.pressed("left")
      xSpeed = X_SPEED
    if @game.input.pressed("up")
      @game.player.acc[1] -= LIFT
    if @game.input.pressed("down")
      ySpeed = Y_SPEED

    @game.player.move(xSpeed, ySpeed)

  spawnBackground: ->
    # each background entity traverses the view in 30 steps over 0.5s, 2s, or 4s
    # the constant on the end gets the right number of pixels for each of the 30 steps.
    spawnWater = if @game.loop.currentTick % 3 == 0 then true else false
    spawnTree = if @game.loop.currentTick % 2 == 0 then true else false
    spawnRock = if @game.loop.currentTick % 17 == 0 then true else false

    if spawnWater
      water = @game.waterFactory.deploy()
      water.moveTo(@game.player.rect().x + 400, 400)
      @viewport.add [water]
    if spawnTree
      @spawnRandomTree()
    if spawnRock
      rock = @game.rockFactory.deploy()
      rock.moveTo(@game.player.rect().x + 400, 200)
      @viewport.add [rock]

  spawnRandomTree: ->
    tree = switch Math.floor Math.random() * 16
      when 0 then @game.tree1Factory.deploy()
      when 1 then @game.tree2Factory.deploy()
      when 2 then @game.tree3Factory.deploy()
      when 3 then @game.tree4Factory.deploy()
      when 4 then @game.tree5Factory.deploy()
      when 5 then @game.tree6Factory.deploy()
      when 6 then @game.tree7Factory.deploy()
      when 7 then @game.tree8Factory.deploy()
      when 8 then @game.tree9Factory.deploy()
      when 9 then @game.tree10Factory.deploy()
      when 10 then @game.tree11Factory.deploy()
      when 11 then @game.tree12Factory.deploy()
      when 12 then @game.tree13Factory.deploy()
      when 13 then @game.tree14Factory.deploy()
      when 14 then @game.tree15Factory.deploy()
      when 15 then @game.tree16Factory.deploy()
      else @game.tree1Factory.deploy()

    tree.moveTo(@game.player.rect().x + 500, (Math.random() * 300))
    @viewport.add(tree)

module.exports = SidescrollerControl
