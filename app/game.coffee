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
      {name:"water1",src:"img/Water.png"}
      {name:"water2",src:"img/water2.png"}
      {name:"water3",src:"img/water3.png"}
      {name:"waterdrops1",src:"img/waterDroplets1.png"}
      {name:"waterdrops2",src:"img/waterDroplets2.png"}
      {name:"waterdrops3",src:"img/waterDroplets3.png"}
      {name:"waterdrops4",src:"img/waterDroplets4.png"}
      {name:"waterdrops5",src:"img/waterDroplets5.png"}
      {name:"waterdrops6",src:"img/waterDroplets6.png"}
      {name:"waterdrops7",src:"img/waterDroplets7.png"}
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
      {name:"treetop1",src:"img/treeTop1.png"}
      {name:"treetop2",src:"img/treeTop2.png"}
      {name:"treetop3",src:"img/treeTop3.png"}
      {name:"treetop4",src:"img/treeTop4.png"}
      {name:"treetop5",src:"img/treeTop5.png"}
      {name:"treetop6",src:"img/treeTop6.png"}
      {name:"treetop7",src:"img/treeTop7.png"}
      {name:"treetop8",src:"img/treeTop8.png"}
      {name:"treetop9",src:"img/treeTop9.png"}
      {name:"treetop10",src:"img/treeTop10.png"}
      {name:"treetop11",src:"img/treeTop11.png"}
      {name:"treetop12",src:"img/treeTop12.png"}
      {name:"treetop13",src:"img/treeTop13.png"}
      {name:"treetop14",src:"img/treeTop14.png"}
      {name:"treetop15",src:"img/treeTop15.png"}
      {name:"treetop16",src:"img/treeTop16.png"}
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
