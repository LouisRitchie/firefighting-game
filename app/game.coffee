SidescrollerState = require 'states/sidescroller_state'
MenuState = require 'states/menu_state'

game = new Rogue.Game
  fps: true
  width: 1000
  height: 600
game.input = new Rogue.Keyboard game.canvas
game.mouse = new Rogue.Mouse game
game.assets = assets = new Rogue.AssetManager
  baseUrl: ""
  packs:
    core: [
      {name:"bg1",src:"img/b1.png"}
      {name:"bg2",src:"img/b2.png"}
      {name:"red",src:"img/1.png"}
      {name:"blue",src:"img/2.png"}
      {name:"tree1",src:"img/bush1.png"}
      {name:"tree2",src:"img/bush2.png"}
      {name:"tree3",src:"img/bush3.png"}
      {name:"tree4",src:"img/bush4.png"}
      {name:"tree5",src:"img/tree1.png"}
      {name:"tree6",src:"img/tree2.png"}
      {name:"tree7",src:"img/tree3.png"}
      {name:"tree8",src:"img/tree4.png"}
      {name:"tree9",src:"img/tree5.png"}
      {name:"tree10",src:"img/tree6.png"}
      {name:"tree11",src:"img/tree7.png"}
      {name:"tree12",src:"img/tree8.png"}
      {name:"tree13",src:"img/tree9.png"}
      {name:"tree14",src:"img/tree10.png"}
      {name:"tree15",src:"img/tree11.png"}
      {name:"tree16",src:"img/bestTree.png"}
      {name:"rock",src:"img/littleFire.gif"}
      {name:"firePlane-side1",src:"img/firePlane-side1.png"}
      {name:"firePlane-side2",src:"img/firePlane-side2.png"}
      {name:"firePlane-top",src:"img/firePlane-top.png"}
      {name:"jump",src:"sound/jump.ogg",alt:"sound/jump.mp3"}
      {name:"menuBlock",src:"shitty_img/shitty_block.png"}
      {name:"littleFire",src:"img/littleFire.gif"}
    ]
  preload: false
assets.on "load","core", (asset,percent) -> console.log "Assets loading: #{percent}"
assets.on "complete","core", -> console.log "Assets loaded"; game.start MenuState
assets.download("core")

module.exports = game
