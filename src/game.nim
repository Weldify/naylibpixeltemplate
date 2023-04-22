import raylib, math


type Game* = object
  gameSize*: Vector2
  mousePosition*: Vector2
  camera: Camera2D


proc createGame*(): Game =
  result.gameSize = Vector2(x: 128'f, y: 128'f)
  result.camera.zoom = 1'f # 0 by default, makes stuff invisible


proc update*(self: var Game) =
  discard


proc draw*(self: var Game) =
  clearBackground(White)

  beginMode2D(self.camera)

  drawLine(64, 64, int32(self.mousePosition.x), int32(self.mousePosition.y), Black)

  endMode2D()