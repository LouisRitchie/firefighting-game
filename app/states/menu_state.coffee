MenuControl = require '../controls/menu_control'
SidescrollerState = require './sidescroller_state'

menuState =
  setup: (game) ->
    console.log "menu setup run"
    assets = game.assets.core

    @viewport = new Rogue.ViewPort
      parent: game
      viewWidth: 1000
      viewHeight: 600

    game.menuBlock = new Rogue.Entity
      name: "menuBlock"
      image: assets.menuBlock
      x: @viewport.viewWidth/2
      y: @viewport.viewHeight/3+0
      require: ["move"]

    @viewport.add [game.menuBlock]

    console.log "[menu_state] logging SidescrollerState that is required: "
    console.log SidescrollerState
    @mc = new MenuControl(game)
    @mc.nextState(SidescrollerState)
    console.log "[menu_state] logging menu control object: "
    console.log @mc

  update: (game,dt) ->
    @mc.respondToInput()
    @viewport.update(dt)

  draw: (game,dt) ->
    game.clear()
    @viewport.draw()

module.exports = menuState
