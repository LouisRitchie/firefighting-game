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

    game.waterdrops1Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "water1"
        image: assets.waterdrops1
        require: ["move"]
    game.waterdrops2Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "water2"
        image: assets.waterdrops2
        require: ["move"]
    game.waterdrops3Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "water3"
        image: assets.waterdrops3
        require: ["move"]
    game.waterdrops4Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "water4"
        image: assets.waterdrops4
        require: ["move"]
    game.waterdrops5Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "water5"
        image: assets.waterdrops5
        require: ["move"]
    game.waterdrops6Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "water6"
        image: assets.waterdrops6
        require: ["move"]
    game.waterdrops7Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "water7"
        image: assets.waterdrops7
        require: ["move"]
    game.treetop1Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "treetop1"
        image: assets.treetop1
        require: ["move"]
    game.treetop2Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "treetop2"
        image: assets.treetop2
        require: ["move"]
    game.treetop3Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "treetop3"
        image: assets.treetop3
        require: ["move"]
    game.treetop4Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "treetop4"
        image: assets.treetop4
        require: ["move"]
    game.treetop5Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "treetop5"
        image: assets.treetop5
        require: ["move"]
    game.treetop6Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "treetop6"
        image: assets.treetop6
        require: ["move"]
    game.treetop7Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "treetop7"
        image: assets.treetop7
        require: ["move"]
    game.treetop8Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "treetop8"
        image: assets.treetop8
        require: ["move"]
    game.treetop9Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "treetop9"
        image: assets.treetop9
        require: ["move"]
    game.treetop10Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "treetop10"
        image: assets.treetop10
        require: ["move"]
    game.treetop11Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "treetop11"
        image: assets.treetop11
        require: ["move"]
    game.treetop12Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "treetop12"
        image: assets.treetop12
        require: ["move"]
    game.treetop13Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "treetop13"
        image: assets.treetop13
        require: ["move"]
    game.treetop14Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "treetop14"
        image: assets.treetop14
        require: ["move"]
    game.treetop15Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "treetop15"
        image: assets.treetop15
        require: ["move"]
    game.treetop16Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "treetop16"
        image: assets.treetop16
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
