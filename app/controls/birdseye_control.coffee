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
    @movePlayer()

  movePlayer: ->
    @viewport.remove(@game.player)
    player = @game.player
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

    @viewport.add [player]
    player.move(xSpeed, ySpeed)

  checkForStateChange: ->
    if @game.input.pressed("escape")
      @game.switchState @menuState
    if @game.input.pressed("enter")
      console.log "changing back to sidescroller..."
      @game.switchState @sidescrollerState

  spawnBackground: ->
    for i in [1...5]
      tree = @spawnTreetop()
      tree.moveTo(Math.random() * 800, @game.player.rect().y - 500)
      @viewport.add [tree]

  spawnTreetop: ->
    return treetop = switch Math.floor Math.random() * 16
      when 0 then @game.treetop1Factory.deploy()
      when 1 then @game.treetop2Factory.deploy()
      when 2 then @game.treetop3Factory.deploy()
      when 3 then @game.treetop4Factory.deploy()
      when 4 then @game.treetop5Factory.deploy()
      when 5 then @game.treetop6Factory.deploy()
      when 6 then @game.treetop7Factory.deploy()
      when 7 then @game.treetop8Factory.deploy()
      when 8 then @game.treetop9Factory.deploy()
      when 9 then @game.treetop10Factory.deploy()
      when 10 then @game.treetop11Factory.deploy()
      when 11 then @game.treetop12Factory.deploy()
      when 12 then @game.treetop13Factory.deploy()
      when 13 then @game.treetop14Factory.deploy()
      when 14 then @game.treetop15Factory.deploy()
      when 15 then @game.treetop16Factory.deploy()

  spawnDrops: ->
    return droplet = switch Math.floor Math.random() * 7
      when 0 then @game.waterdrops1Factory.deploy()
      when 1 then @game.waterdrops2Factory.deploy()
      when 2 then @game.waterdrops3Factory.deploy()
      when 3 then @game.waterdrops4Factory.deploy()
      when 4 then @game.waterdrops5Factory.deploy()
      when 5 then @game.waterdrops6Factory.deploy()
      when 6 then @game.waterdrops7Factory.deploy()

module.exports = BirdseyeControl
