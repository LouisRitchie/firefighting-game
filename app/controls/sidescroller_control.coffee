class SidescrollerControl

  X_SPEED = 5
  Y_SPEED = 5
  BG_SPEED = 1
  GRAVITY = 1
  LIFT = 1.5
  TANK = 0
  TANK_COEF = 0.0025
  FILL_RATE = .5
  DEAD_ZONE = 425
  LEVEL_TIME = 0

  constructor: (game, viewport) ->
    @game = game
    @viewport = viewport
    @menuState = require '../states/menu_state'
    @birdseyeState = require '../states/birdseye_state'

  nextMove: ->
    @checkForStateChange()
    @addAcceleration()
    @spawnBackground()
    LEVEL_TIME++
    #console.log LEVEL_TIME
    @movePlayer()

  checkForStateChange: ->
    if @game.input.pressed("escape")
      @game.assets.core.watermusic.pause()
      @game.switchState @menuState
    if @game.input.pressed("backspace")
      @game.switchState @birdseyeState
      @game.assets.core.watermusic.pause()
      

  addAcceleration: ->

  movePlayer: ->
    @viewport.remove(@game.player)
    player = @game.player
    xSpeed = X_SPEED
    ySpeed = 0
    @game.player.acc[1] += GRAVITY if @game.player.acc[1] <=1.0

    if @game.player.y >= 350 and TANK < 100
        TANK += FILL_RATE

    #console.log "TANK: " + TANK + ". MAX LIFT: " + (LIFT - (TANK_COEF*TANK))
    #console.log @game.player.y

    if @game.player.y > DEAD_ZONE or @game.player.y < 0
      console.log "game over. back to menu"
      TANK = 0
      LEVEL_TIME = 0
      @game.switchState @menuState
      @game.assets.core.watermusic.pause()
    if LEVEL_TIME == 400
      console.log "WARNING: TIME ALMOST UP"
    if LEVEL_TIME == 600
      console.log "TIME UP"
      @game.switchState @birdseyeState
      @game.assets.core.watermusic.pause()

    if @game.input.pressed("space") and TANK > 50
      console.log "Switching to BirdsEye"
      @game.switchState @birdseyeState
      @game.assets.core.watermusic.pause()

    if @game.input.pressed("right")
      xSpeed = X_SPEED * 1.2
    if @game.input.pressed("left")
      xSpeed = X_SPEED * 0.8
    if @game.input.pressed("up")
      @game.player.acc[1] += -LIFT + (TANK_COEF*TANK)
    if @game.input.pressed("down")
      @game.player.acc[1] += LIFT + (TANK_COEF*TANK)

    @viewport.add [player]
    player.move(xSpeed, ySpeed)

  spawnBackground: ->
    if @game.loop.currentTick % 17 == 0
      rock = @spawnRock()
      rock.moveTo(@game.player.rect().x + 500, Math.random() * 200)
      @viewport.add [rock]
    if @game.loop.currentTick % 3 == 0
      tree = @spawnTree()
      tree.moveTo(@game.player.rect().x + 500, 150 + Math.random() * 200)
      @viewport.add [tree]
    if @game.loop.currentTick % 2 == 0
      water = @spawnWater()
      water.moveTo(@game.player.rect().x + 600, 400 + Math.random() * 20)
      @viewport.add [water]
    if @game.player.y >= 350
      drops = @spawnDrops()
      drops.moveTo(@game.player.rect().x + 10 + Math.random() * 20, @game.player.rect().y + 28 + Math.random() * 20)
      drops.move(-5, 5)
      @viewport.add [drops]

  spawnTree: ->
    return tree = switch Math.floor Math.random() * 16
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

  spawnWater: ->
    return water = switch Math.floor Math.random() * 3
      when 0 then @game.water1Factory.deploy()
      when 1 then @game.water2Factory.deploy()
      when 2 then @game.water3Factory.deploy()

  spawnDrops: ->
    return drops = switch Math.floor Math.random() * 7
      when 0 then @game.waterdrops1Factory.deploy()
      when 1 then @game.waterdrops2Factory.deploy()
      when 2 then @game.waterdrops3Factory.deploy()
      when 3 then @game.waterdrops4Factory.deploy()
      when 4 then @game.waterdrops5Factory.deploy()
      when 5 then @game.waterdrops6Factory.deploy()
      when 6 then @game.waterdrops7Factory.deploy()

  spawnRock: ->
    return rock = @game.rockFactory.deploy()

  initializeBackground: ->
    for each in [1...30]
      water = @spawnWater()
      water.moveTo(Math.random() * 800, 400 + Math.random() * 20)
      tree = @spawnTree()
      tree.moveTo(Math.random() * 800, Math.random() * 300)
      @viewport.add [water, tree]
    for each in [1...4]
      rock = @spawnRock()
      rock.moveTo(Math.random() * 800, Math.random() * 200)
      @viewport.add [rock]

  getTank: ->
    return TANK

module.exports = SidescrollerControl
