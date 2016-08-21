
import CSDL2
import SDL

import func Darwin.round

extension V2 {

  func translate(for window: Window) -> V2 {
    return V2(x: round(x), y: round(-y + Double(window.size.h)))
  }
}

func render(_ gameState: GameState, to graphics: Graphics, with assetData: AssetData) throws {

  let (window, renderer) = (graphics.window, graphics.renderer)
  let characterSpriteSheet = assetData

  /// TODO(vdka): change signature to `swap(_ vector: V2, from: CoordinateSystem, to: CoordinateSystem)`
  /// translates game Coordinates into renderer coordinates
  func translateToRenderer(coordinates input: V2) -> V2 {
    return V2(x: round(input.x), y: round(-input.y + Double(window.size.h)))
  }

  try renderer.setDrawColor(rgb: 0x222222)
  try renderer.clear()

  try renderer.setDrawColor(rgb: 0xffffff)

  try renderer.drawLine(x1: 0, y1: 0, x2: window.size.w, y2: window.size.h)

  // frame = f(keyfps: keyFramesPerSecond, fps, curFrame) { curFrame / (fps / keyfps) }
  let x = gameState.player.isMoving ? graphics.frameCounter.frames / (60 / 4) : 0

  let spriteRect: Rect
  switch gameState.player.facing?.components {
  case (1, 0)?:
    spriteRect = characterSpriteSheet.getSpriteRect(for: V2(x, x))

  case (-1, 0)?:
    spriteRect = characterSpriteSheet.getSpriteRect(for: V2(x, x))

  case (0, 1)?:
    spriteRect = characterSpriteSheet.getSpriteRect(for: V2(x, x))

  case (0, -1)?:
    spriteRect = characterSpriteSheet.getSpriteRect(for: V2(x, x))

  case (1, 1)?, (-1, -1)?, (-1, 1)?, (1, -1)?:
    spriteRect = characterSpriteSheet.getSpriteRect(for: .zero)
    log.warning("Player moving on 2 axis")

  default:
    spriteRect = characterSpriteSheet.getSpriteRect(for: .zero)
  }

  let playerRect = Rect(center: gameState.player.position.translate(for: window), size: V2(Player.width * 2, Player.width * 2))

  try renderer.copy(texture: characterSpriteSheet.texture, sourceRect: spriteRect, destRect: playerRect)

  renderer.present()
}
