
import CSDL2
import SDL
import Shared

@_silgen_name("initialize")
public func initialize() -> UnsafeMutablePointer<Byte>? {

  do {

    try SDL.initialize(components: .video)

    var (window, renderer) = try SDL.createWindowAndRenderer(w: 200, h: 360, windowFlags: [.shown])

    let startScreen = SDL_GetNumVideoDisplays()
    window.setPosition(x: Int32.WindowPosition.centered | (startScreen - 2), y: Int32.WindowPosition.centered | (startScreen - 2))

    var gameState = GameState(score: 450, xPos: 0, yPos: 0)

    let totalMemoryRequired = sizeofValue(window) + sizeofValue(renderer) + sizeofValue(gameState)

    let memory = UnsafeMutablePointer<Byte>(allocatingCapacity: totalMemoryRequired)

    var ticks = SDL_GetTicks()

    write(&window, &renderer, &gameState, &ticks, to: memory)

    return memory
  } catch {

    print("ERROR: Encounted during initialization \(error)")
    return nil
  }
}

