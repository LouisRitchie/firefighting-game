BirdseyeControl = require "../controls/birdseye_control"

PLAYER_JUMP_ACC = -40 #This should be a negative value
X_SPEED = 5
Y_SPEED = 5
BG_SPEED = 1

state =
  setup: (game) ->
    console.log "birdseye setup run"
    assets = game.assets.core

    @viewport = new Rogue.ViewPort
      parent: game
      width: 800
      height: 600
      viewHeight: 100000

    game.bg1 = new Rogue.Entity
      name: "bg1"
      image: assets.bg1
      require: ["move"]
    game.bg2 = new Rogue.Entity
      name: "bg2"
      image: assets.bg2
      require: ["move"]
    game.player = new Rogue.Entity
      name: "player"
      image: assets['firePlane-top']
      require: ["move","collide","AABB","physics"]
      tank: game.oldState.viewport.player.tank

    tiles = new Rogue.TileMap
      name: "tiles"
      x: 0
      y: -32
      size: [1000,1]

    game.waterFactory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "water"
        image: assets.blue
        require: ["move"]

    game.tree1Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "tree"
        image: assets.tree1
        require: ["move"]

    game.rockFactory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "rock"
        image: assets.rock
        require: ["move"]

    @viewport.add [game.bg1, game.bg2,  game.player, tiles]
    @viewport.updates.push ->
      @follow @player
      @forceInside @player, false

    game.player.moveTo(300, 300)
    game.bg1.moveTo(300, 300)
    game.bg2.moveTo(400, 300)
    @viewport.tiles.place new Rogue.Entity({image: assets.red, x: x, y: 0, require: ["sprite","collide","AABB"]}) for x in [0...@viewport.tiles.size[0]]

  update: (game,dt) ->
    #console.log game.oldState.viewport.player.tank
    bc = new BirdseyeControl(game, @viewport)
    bc.nextMove()
    @viewport.update(dt)

  draw: (game,dt) ->
    game.clear()
    @viewport.draw()

module.exports = state
