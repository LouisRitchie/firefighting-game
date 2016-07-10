class sidescrollerControl
  constructor: (game, xBase, yBase, bgBase) ->
    @game = game
    @player = @game.player
    @bg1 = @game.bg1
    @bg2 = @game.bg2
    @xSpeed = xBase
    @ySpeed = yBase
    @bgSpeed = bgBase
    return @

  nextState: (nextState) ->
    console.log "[sidescroller_control] [nextState] logging nextState: "
    console.log nextState
    @nextState = nextState

  respondToInput: ->
    xSpeed = 0
    ySpeed = 0

    if @game.input.pressed("right")
      xSpeed = @xSpeed
    if @game.input.pressed("left")
      xSpeed = -@xSpeed
    if @game.input.pressed("up")
      ySpeed = -@ySpeed
    if @game.input.pressed("down")
      ySpeed = @ySpeed

    @bg1.move(-@bgSpeed, 0)
    @bg2.move(-@bgSpeed, 0)
    @player.move(xSpeed, ySpeed)

    if @game.input.pressed("escape")
      console.log "[sidescroller control] logging nextState: "
      console.log @nextState
      @game.switchState @nextState

module.exports = sidescrollerControl
