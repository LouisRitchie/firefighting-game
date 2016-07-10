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
      viewWidth: 600
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
    game.player.ev.on "hit", (col) -> if col.dir is "bottom" then @canJump = true

    tiles = new Rogue.TileMap
      name: "tiles"
      y: 500
      size: [1,1000]

    @viewport.add [game.bg1, game.bg2,  game.player, tiles]
    @viewport.updates.push ->
      @follow @player
      @forceInside @player, false

    game.player.moveTo(300, 300)
    game.bg1.moveTo(300, 300)
    game.bg2.moveTo(400, 300)
    @viewport.tiles.place new Rogue.Entity({image: assets.red, x: x, y: 0, require: ["sprite","collide","AABB"]}) for x in [0...@viewport.tiles.size[0]]

  update: (game,dt) ->
    bc = new BirdseyeControl(game)
    bc.nextMove()
    @viewport.update(dt)

  draw: (game,dt) ->
    game.clear()
    @viewport.draw()

module.exports = state
