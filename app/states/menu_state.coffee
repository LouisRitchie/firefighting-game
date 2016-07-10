MenuControl = require '../controls/menu_control'

menuState =
  setup: (game) ->
    console.log "menu setup run"
    assets = game.assets.core

    @viewport = new Rogue.ViewPort
      parent: game
      width: 800
      height: 600

    game.menuBlock = new Rogue.Entity
      name: "menuBlock"
      image: assets.menuBlock
      x: @viewport.viewWidth/2
      y: @viewport.viewHeight/3+0
      require: ["move"]

    @viewport.add [game.menuBlock]

  update: (game,dt) ->
    mc = new MenuControl(game)
    mc.nextMove()
    @viewport.update(dt)

  draw: (game,dt) ->
    game.clear()
    @viewport.draw()

module.exports = menuState
