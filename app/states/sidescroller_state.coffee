SidescrollerControl = require "../controls/sidescroller_control"

PLAYER_JUMP_ACC = -40 #This should be a negative value
X_SPEED = 5
Y_SPEED = 5
BG_SPEED = 1

state =
  setup: (game) ->
    console.log "setup run"
    assets = game.assets.core

    @viewport = new Rogue.ViewPort
      parent: game
      width: 800
      height: 600
      viewWidth: 100000

    game.player = new Rogue.Entity
      name: "player"
      image: assets['firePlane-side2']
      require: ["move","collide","AABB","physics"]

    game.doneButton = new Rogue.Entity
      name: "doneButton"
      image: assets.menuBlock
      x: -200
      y: 50
      require: ["move"]

    game.water1Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "water1"
        image: assets.water1
        require: ["move"]
    game.water2Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "water2"
        image: assets.water2
        require: ["move"]
    game.water3Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "water3"
        image: assets.water3
        require: ["move"]
    game.waterdrops1Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "waterdrops1"
        image: assets.waterdrops1
        require: ["move"]
    game.waterdrops2Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "waterdrops2"
        image: assets.waterdrops2
        require: ["move"]
    game.waterdrops3Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "waterdrops3"
        image: assets.waterdrops3
        require: ["move"]
    game.waterdrops4Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "waterdrops4"
        image: assets.waterdrops4
        require: ["move"]
    game.waterdrops5Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "waterdrops5"
        image: assets.waterdrops5
        require: ["move"]
    game.waterdrops6Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "waterdrops6"
        image: assets.waterdrops6
        require: ["move"]
    game.waterdrops7Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "waterdrops7"
        image: assets.waterdrops7
        require: ["move"]

    game.tree1Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "tree1"
        image: assets.tree1
        require: ["move"]
    game.tree2Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "tree2"
        image: assets.tree2
        require: ["move"]
    game.tree3Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "tree3"
        image: assets.tree3
        require: ["move"]
    game.tree4Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "tree4"
        image: assets.tree4
        require: ["move"]
    game.tree5Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "tree5"
        image: assets.tree5
        require: ["move"]
    game.tree6Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "tree6"
        image: assets.tree6
        require: ["move"]
    game.tree7Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "tree7"
        image: assets.tree7
        require: ["move"]
    game.tree8Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "tree8"
        image: assets.tree8
        require: ["move"]
    game.tree9Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "tree9"
        image: assets.tree9
        require: ["move"]
    game.tree10Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "tree10"
        image: assets.tree10
        require: ["move"]
    game.tree11Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "tree11"
        image: assets.tree11
        require: ["move"]
    game.tree12Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "tree12"
        image: assets.tree12
        require: ["move"]
    game.tree13Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "tree13"
        image: assets.tree13
        require: ["move"]
    game.tree14Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "tree14"
        image: assets.tree14
        require: ["move"]
    game.tree15Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "tree15"
        image: assets.tree15
        require: ["move"]
    game.tree16Factory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "tree16"
        image: assets.tree16
        require: ["move"]
    game.rockFactory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "rock"
        image: assets.rock
        require: ["move"]

    initialBackground = @generateInitialBackground(game)

    # add these objects to the view
    @viewport.add [game.player, game.doneButton]
    @viewport.updates.push ->
      @follow @player
      @forceInside @player, false

    # initial positions
    game.player.moveTo(300, 300)

  update: (game,dt) ->
    sc = new SidescrollerControl(game, @viewport)
    sc.nextMove()

    if sc.getFullTank() == 100
      console.log "full"
      game.doneButton.x = game.player.x+250

    @viewport.update(dt)

  draw: (game,dt) ->
    game.clear()
    @viewport.draw()

#--------------------------------------------------------------------------------
# Helper functions
#--------------------------------------------------------------------------------
  generateInitialBackground: (game) ->
    sc = new SidescrollerControl(game, @viewport)
    sc.initializeBackground()

module.exports = state
