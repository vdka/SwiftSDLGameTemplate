
import SDL
import Shared

@_silgen_name("initialize")
func initialize() -> UnsafeMutablePointer<Byte>? {

  var gameState = GameState(score: 450)

  var (window, renderer) = try SDL.createWindowAndRenderer(w: 200, h: 360, windowFlags: [.shown])

  window.setPosition(x: Int32.WindowPosition.centered | (startScreen - 2), y: Int32.WindowPosition.centered | (startScreen - 2))

  //initialize SDL Renderer and Window

  let memory = UnsafeMutablePointer<Byte>(allocatingCapacity: sizeofValue(gameState))

  gameState.write(to: memory)

  return memory
}

