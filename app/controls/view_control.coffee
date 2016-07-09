viewControl =
  viewControl: (game, xBase, yBase, bgBase) ->
    @game = game
    @player = @game.player
    @bg1 = @game.bg1
    @xSpeed = xBase
    @ySpeed = yBase
    @bgSpeed = bgBase
    return @

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
    @player.move(xSpeed, ySpeed)

module.exports = viewControl
