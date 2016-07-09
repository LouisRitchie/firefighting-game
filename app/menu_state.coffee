WATER_GAIN_RATE = 1
WATER_LOSS_RATE = 10
waterMeter = 0


menuState =
  setup: (game) ->
    console.log "menu setup run"
    assets = game.assets.core

    @viewport = new Rogue.ViewPort
      parent: game
      viewWidth: 1000
      viewHeight: 600

    game.bg1 = new Rogue.Entity
      name: "bg1"
      image: assets.bg1
      require: ["move"]
      
    tiles = new Rogue.TileMap
      name: "tiles"
      y: 500
      size: [1000,1]
      
    game.menuBlock = new Rogue.Entity
      name: "menuBlock"
      image: assets.menuBlock
      x: @viewport.viewWidth/2
      y: @viewport.viewHeight/3+0
      require: ["move"]
      
    

    @viewport.add [game.bg1, game.menuBlock, tiles]  

    game.player.moveTo(300, 300)
    game.bg1.moveTo(300, 300)
    @viewport.tiles.place new Rogue.Entity({image: assets.red, x: x, y: 0, require: ["sprite","collide","AABB"]}) for x in [0...@viewport.tiles.size[0]]


  update: (game,dt) ->
    input = game.input
    
    state = require 'state'
    if input.pressed("enter")
      game.switchState state
    
    if input.pressed("right")
      waterMeter += WATER_GAIN_RATE
    
    if input.pressed("left")
      waterMeter -= WATER_LOSS_RATE
    
    #Last thing in update
    @viewport.update(dt)

  draw: (game,dt) ->
    game.clear()
    @viewport.draw()

module.exports = menuState
