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
      image: assets['firePlane-side2']
      require: ["move","collide","AABB","physics"]
    game.player.ev.on "hit", (col) -> if col.dir is "bottom" then @canJump = true
    
    game.doneButton = new Rogue.Entity
      name: "doneButton"
      image: assets.menuBlock
      x: -200 #@viewport.viewWidth/2
      y: 50 #@viewport.viewHeight/3+0
      require: ["move"]
      opacity: 255

    tiles = new Rogue.TileMap
      name: "tiles"
      y: 500
      size: [1000,1]

    game.waterFactory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "water"
        image: assets.blue
        require: ["move"]

    game.treeFactory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "tree"
        image: assets.tree
        require: ["move"]

    game.rockFactory = new Rogue.Factory
      entity: Rogue.Entity
      options:
        name: "rock"
        image: assets.rock
        require: ["move"]

    # add these objects to the view
    @viewport.add [game.player, tiles]
    @viewport.add [game.doneButton]
    @viewport.updates.push ->
      @follow @player
      @forceInside @player, false

    # initial positions
    game.player.moveTo(300, 200)
    game.bg1.moveTo(300, 300)
    game.bg2.moveTo(400, 300)

    @viewport.tiles.place new Rogue.Entity({image: assets.red, x: x, y: 0, require: ["sprite","collide","AABB"]}) for x in [0...@viewport.tiles.size[0]]

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

module.exports = state
