BirdseyeControl = require "../controls/birdseye_control"

PLAYER_JUMP_ACC = -40 #This should be a negative value
X_SPEED = 5
Y_SPEED = 5
BG_SPEED = 1

state =
  setup: (game) ->
    console.log "birdseye setup run"
    assets = game.assets.core

    game.assets.core.firemusic.play()

    @viewport = new Rogue.ViewPort
      parent: game
      width: 800
      height: 600
      viewHeight: 100000

    game.player = new Rogue.Entity
      name: "player"
      image: assets['firePlane-top']
      require: ["move","collide","AABB","physics"]

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

    @viewport.add [game.player]
    @viewport.updates.push ->
      @follow @player
      @forceInside @player, false

    game.player.moveTo(300, 99999)

  update: (game,dt) ->
    bc = new BirdseyeControl(game, @viewport)
    bc.nextMove()
    @viewport.update(dt)

  draw: (game,dt) ->
    game.clear()
    @viewport.draw()

module.exports = state
