X_SPEED = 6
Y_SPEED = 4
PLAYER_JUMP_ACC = -40 #This should be a negative value

state =
  setup: (game) ->
    console.log "setup run"
    assets = game.assets.core

    @viewport = new Rogue.ViewPort
      parent: game
      viewWidth: 100000
      viewHeight: 600

    bg1 = new Rogue.Entity
      name: "bg1"
      image: assets.bg1
      speed: 0.1
      repeatX: true
      require: ["layer"]
    bg2 = new Rogue.Entity
      name: "bg2"
      image: assets.bg2
      speed: 0.1
      repeatX: true
      require: ["layer"]
    game.player = new Rogue.Entity
      name: "player"
      image: assets.firePlane
      require: ["move","collide","AABB","physics"]
    game.player.ev.on "hit", (col) -> if col.dir is "bottom" then @canJump = true

    tiles = new Rogue.TileMap
      name: "tiles"
      y: 500
      size: [1000,1]

    @viewport.add [bg2, bg1, game.player, tiles]
    @viewport.updates.push ->
      @follow @player
      @forceInside @player, false

    @viewport.tiles.place new Rogue.Entity({image: assets.red, x: x, y: 0, require: ["sprite","collide","AABB"]}) for x in [0...@viewport.tiles.size[0]]

  update: (game,dt) ->
    player = game.player
    input = game.input
    xSpeed = X_SPEED
    ySpeed = Y_SPEED

    if input.pressed("right")
      xSpeed = X_SPEED * 1.4
    if input.pressed("left")
      xSpeed = X_SPEED * 0.6
    if input.pressed("up")
    	ySpeed = -Y_SPEED * 1.4
    if input.pressed("down")
    	ySpeed = Y_SPEED * 2

    player.move(xSpeed, ySpeed)

    _.map game.e, (e) -> console.log e
    debugger
    ###if input.pressed("up")
      if player.canJump
        #game.assets.core.jump.play()
        player.canJump = false
        player.acc[1] = PLAYER_JUMP_ACC
    ###
    if input.pressed("down")
      player.move(0,2)

    @viewport.update(dt)

  draw: (game,dt) ->
    game.clear()
    @viewport.draw()

module.exports = state
