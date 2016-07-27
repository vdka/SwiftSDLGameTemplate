
import CSDL2
import SDL

public func render(_ gameState: GameState, to window: Window, with renderer: Renderer) throws {

  /// TODO(vdka): change signature to `swap(_ vector: V2, from: CoordinateSystem, to: CoordinateSystem)`
  /// translates game Coordinates into renderer coordinates
  func translate(coordinates input: V2) -> V2 {
    return V2(x: input.x, y: -input.y + Double(window.size.h))
  }

  try renderer.setDrawColor(r: 0x22, g: 0x22, b: 0x22, a: 0x22)
  try renderer.clear()

  try renderer.setDrawColor(r: 0xff, g: 0xff, b: 0xff, a: 0xff)

  try renderer.drawLine(x1: 0, y1: 0, x2: window.size.w, y2: window.size.h)

  try renderer.setDrawColor(r: 0x00, g: 0xcc, b: 0xff, a: 0xff)

  var rect = Rect(origin: translate(coordinates: gameState.player.position), size: V2(Double(gameState.player.width), Double(gameState.player.width)))

  try renderer.fill(rect: &rect)

  renderer.present()
}
