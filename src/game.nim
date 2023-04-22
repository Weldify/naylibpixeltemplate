import raylib, math


type Game* = object
  gameSize*: Vector2
  camera: Camera2D


proc createGame*(): Game =
  result.gameSize = Vector2(x: 128'f, y: 128'f)
  result.camera.zoom = 1'f # 0 by default, makes stuff invisible


proc update*(self: var Game) =
  discard


proc draw*(self: var Game) =
  clearBackground(White)

  beginMode2D(self.camera)
  
  var
    spinHor = cos(getTime() * 3'f) * 10'f
    spinVer = sin(getTime() * 3'f) * 10'f

  drawLine(64, 64, 64 + int32(spinHor.round), 64 + int32(spinVer.round), Black)

  endMode2D()