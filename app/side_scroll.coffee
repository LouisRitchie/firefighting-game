TANK = 0
GRAVITY = 0.5
PLAYER_MOMENTUM = 0
PLAYER_V_SPEED = -0.5

sideState =
  setup: (game) ->
    console.log "side scroll run"
    assets = game.assets.core

    @viewport = new Rogue.ViewPort
      parent: game
      viewWidth: 100000
      viewHeight: 600

    bg1 = new Rogue.Entity
      name: "bg1"
      image: assets.bg1
      speed: 0.5
      repeatX: true
      require: ["layer"]
    bg2 = new Rogue.Entity
      name: "bg2"
      image: assets.bg2
      speed: 0.9
      repeatX: true
      require: ["layer"]
    console.log "here"
    game.player = new Rogue.Entity
      name: "player"
      image: assets.firePlane
      require: ["move","collide","AABB","physics"]
    #game.player.behavior.add "gravity"
    #game.player.ev.on "hit", (col) -> if col.dir is "bottom" then @canJump = true 

    tiles = new Rogue.TileMap
      name: "tiles"
      y: 500
      size: [1000,1]

    @viewport.add [game.bg1, game.player, tiles]
    @viewport.updates.push ->
      @follow @player
      @forceInside @player, false

    game.player.moveTo(100, 100)
    game.bg1.moveTo(300, 300)
    @viewport.tiles.place new Rogue.Entity({image: assets.red, x: x, y: 0, require: ["sprite","collide","AABB"]}) for x in [0...@viewport.tiles.size[0]]

  update: (game,dt) ->
    player = game.player
    input = game.input
	
    xSpeed = 3
	
    player.acc[1] = GRAVITY if player.acc[1] < (GRAVITY*3)
    console.log player.acc[1]

    if input.pressed("right")
      xSpeed = xSpeed * 1.4
    if input.pressed("left")
      xSpeed = xSpeed * 0.6
    if input.pressed("up")
      player.acc[1] = PLAYER_V_SPEED
    if input.pressed("down")
      player.move(0,2)

    player.move(xSpeed,0)
    @viewport.update(dt)
	
  draw: (game,dt) ->
    game.clear()
    @viewport.draw()

module.exports = sideState