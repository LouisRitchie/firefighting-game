class BirdseyeControl

  X_SPEED = 5
  Y_SPEED = -7
  BG_SPEED = 1

  constructor: (game, viewport) ->
    @game = game
    @viewport = viewport
    @menuState = require '../states/menu_state'
    @sidescrollerState = require '../states/sidescroller_state'

  nextMove: ->
    @checkForStateChange()
    @spawnBackground()
    xSpeed = 0
    ySpeed = Y_SPEED

    if @game.input.pressed("right")
      xSpeed = X_SPEED
    if @game.input.pressed("left")
      xSpeed = -X_SPEED
    if @game.input.pressed("up")
      ySpeed = Y_SPEED * 1.3
    if @game.input.pressed("down")
      ySpeed = -Y_SPEED * 0.6

    @game.player.move(xSpeed, ySpeed)

  checkForStateChange: ->
    if @game.input.pressed("escape")
      @game.switchState @menuState
    if @game.input.pressed("enter")
      console.log "changing back to sidescroller..."
      @game.switchState @sidescrollerState

  spawnBackground: ->
    # each background entity traverses the view in 30 steps over 0.5s, 2s, or 4s
    # the constant on the end gets the right number of pixels for each of the 30 steps.
    spawnWater = if @game.loop.currentTick % 3 == 0 then true else false
    spawnTree = if @game.loop.currentTick % 15 == 0 then true else false
    spawnRock = if @game.loop.currentTick % 17 == 0 then true else false

    if spawnWater
      water = @game.waterFactory.deploy()
      water.moveTo(@game.player.rect().x + 64, @game.player.rect().y + 148)
      @viewport.add [water]
    if spawnTree
      tree = @game.tree1Factory.deploy()
      tree.moveTo(Math.random() * 800, @game.player.rect().y - 500)
      @viewport.add [tree]
    if spawnRock
      rock = @game.rockFactory.deploy()
      rock.moveTo(Math.random() * 800, @game.player.rect().y - 500)
      @viewport.add [rock]

module.exports = BirdseyeControl
