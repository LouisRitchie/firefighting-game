PLAYER_MOMENTUM = 0
GRAVITY = 0.5
	
viewControl =
  viewControl: (game, xBase, yBase, bgBase) ->
    @game = game
    @player = @game.player
    @bg1 = @game.bg1
    @xSpeed = xBase
    @ySpeed = yBase
    @bgSpeed = bgBase
    return @

  respondToInput: (game) ->
    #@game = game
    #@player = @game.player
    xSpeed = 3
    ySpeed = 3	
    
    @player.acc[1] += GRAVITY if @player.acc[1] <= 1.0
    #console.log @player.acc[1]

    if @game.input.pressed("right")
      xSpeed = @xSpeed * 1.4
    if @game.input.pressed("left")
      xSpeed = @xSpeed * 0.6
    if @game.input.pressed("up")
      @player.acc[1] += -0.75
      ySpeed = -@ySpeed
      console.log @player.acc[1]
    if @game.input.pressed("down")
      ySpeed = @ySpeed

    @bg1.move(-@bgSpeed, 0)
    @player.move(xSpeed,ySpeed)

module.exports = viewControl
