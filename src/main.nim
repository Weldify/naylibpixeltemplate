import raylib, math, raymath, game

proc main =
  setConfigFlags(flags(ConfigFlags.WindowResizable))
  initWindow(640, 480, "Game")
  defer: closeWindow()

  setTargetFPS(60)

  var 
    game = Game.create()
    renderCamera = Camera2D()
    renderTarget = loadRenderTexture(int32(game.gameSize.x), int32(game.gameSize.y))
    sourceRect = Rectangle(
      x: 0'f, y: 0'f, 
      width: game.gameSize.x, height: -game.gameSize.y
    )

  renderCamera.zoom = 1'f # 0 by default, makes stuff invisible

  while not windowShouldClose():
    var
      # float32 is more convenient
      screenSize = Vector2(x: float32(getScreenWidth()), y: float32(getScreenHeight()))

      renderOrigin = Vector2(x: round(-screenSize.x/2'f), y: round(-screenSize.y/2'f))

      widthScale = max(1'f, floor(screenSize.x / game.gameSize.x))
      heightScale = max(1'f, floor(screenSize.y / game.gameSize.y))
      
      # Scale must fit within both axes
      renderScale = min(widthScale, heightScale)
      renderSize = game.gameSize * renderScale

      # Gap between the game display and the window itself
      screenGap = Vector2(x: -renderOrigin.x - renderSize.x/2'f, y: -renderOrigin.y - renderSize.y/2'f)

    # Calculate mouse position relative to game
    let mousePos = (getMousePosition() - screenGap)/renderScale
    game.mousePosition = Vector2(x: mousePos.x.round, y: mousePos.y.round).clamp(Vector2.zero, game.gameSize)
    game.update()

    # Draw game to render target
    beginTextureMode(renderTarget)
    game.draw()
    endTextureMode()

    var destRect = Rectangle(
      x: round(-renderSize.x/2'f), y: round(-renderSize.y/2'f),
      width: renderSize.x, height: renderSize.y
    )

    # Draw render target to screen
    beginDrawing()
    clearBackground(Black)
    beginMode2D(renderCamera)

    drawTexture(renderTarget.texture, sourceRect, destRect, renderOrigin, 0'f, White)

    endMode2D()
    endDrawing()


main()
