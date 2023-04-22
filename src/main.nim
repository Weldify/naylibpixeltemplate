import raylib, math, game

proc main =
  setConfigFlags(flags(ConfigFlags.WindowResizable))
  initWindow(640, 480, "Game")
  defer: closeWindow()

  setTargetFPS(60)

  var 
    game = createGame()
    renderCamera = Camera2D()
    renderTarget = loadRenderTexture(game.gameWidth, game.gameHeight)
    sourceRect = Rectangle(
      x: 0'f, y: 0'f, 
      width: float32(game.gameWidth), height: float32(-game.gameHeight)
    )

  renderCamera.zoom = 1'f # 0 by default, makes stuff invisible

  while not windowShouldClose():
    game.update()

    # Draw game to render target
    beginTextureMode(renderTarget)
    game.draw()
    endTextureMode()

    var
      # float32 is more convenient
      screenWidth = float32(getScreenWidth())
      screenHeight = float32(getScreenHeight())
      
      # Render at screen center
      renderOrigin = Vector2(x: -screenWidth/2'f, y: -screenHeight/2'f)
      
      widthScale = max(1'f, floor(screenWidth / float32(game.gameWidth)))
      heightScale = max(1'f, floor(screenHeight / float32(game.gameHeight)))
      
      # Scale must fit within both axes
      renderScale = min(widthScale, heightScale)

      renderWidth = float32(game.gameWidth) * renderScale
      renderHeight = float32(game.gameHeight) * renderScale

      destRect = Rectangle(
        x: round(-renderWidth/2'f), y: round(-renderHeight/2'f),
        width: renderWidth, height: renderHeight
      )

    # Draw render target to screen
    beginDrawing()
    clearBackground(Black)
    beginMode2D(renderCamera)

    drawTexture(renderTarget.texture, sourceRect, destRect, renderOrigin, 0'f, White)

    endMode2D()
    endDrawing()


main()