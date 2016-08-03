
import CSDL2
import SDL

import func Darwin.round

func render(_ gameState: GameState, to graphics: Graphics) throws {

  let (window, renderer) = (graphics.window, graphics.renderer)

  /// TODO(vdka): change signature to `swap(_ vector: V2, from: CoordinateSystem, to: CoordinateSystem)`
  /// translates game Coordinates into renderer coordinates
  func translateToRenderer(coordinates input: V2) -> V2 {
    return V2(x: round(input.x), y: round(-input.y + Double(window.size.h)))
  }

  try renderer.setDrawColor(rgb: 0x222222)
  try renderer.clear()

  try renderer.setDrawColor(rgb: 0xffffff)

  try renderer.drawLine(x1: 0, y1: 0, x2: window.size.w, y2: window.size.h)


  switch gameState.player.state {
  case .idle:
    try renderer.setDrawColor(rgb: 0x009a49)
  case .standing:
    try renderer.setDrawColor(rgb: 0x10aa49)
  case .moving(_):
    try renderer.setDrawColor(rgb: 0xaa1010)
  }

  var rect = Rect(center: translateToRenderer(coordinates: gameState.player.position), size: V2(Double(gameState.player.width), Double(gameState.player.width)))

  try renderer.fill(rect: &rect)

  renderer.present()
}
