
import CSDL2
import SDL
import Shared

public func render(_ gameState: GameState, to window: Window, with renderer: Renderer) throws {

  try renderer.setDrawColor(r: 0x22, g: 0x22, b: 0x22, a: 0x22)
  try renderer.clear()

  try renderer.setDrawColor(r: 0xff, g: 0xff, b: 0xff, a: 0xff)

  try renderer.drawLine(x1: 0, y1: 0, x2: window.size.w, y2: window.size.h)

  try renderer.setDrawColor(r: 0x00, g: 0xcc, b: 0xff, a: 0xff)

  var rect = Rect(x: gameState.xPos, y: gameState.yPos, w: 20, h: 20)

  try renderer.fill(rect: &rect)

  renderer.present()
}

