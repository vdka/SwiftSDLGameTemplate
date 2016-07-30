
import CSDL2
import SDL


/// Only ever called once when the game is first launched. Use this to set up a state that can be persisted to Raw Memory between reloads of libGameEngine.dylib
@_silgen_name("load")
public func initialize() -> UnsafeMutablePointer<Byte>? {

  defer { loadConfiguration() }

  do {

    // MARK: - Setup
    try SDL.initialize(components: .video)

    let (window, renderer) = try SDL.createWindowAndRenderer(w: 360, h: 360, windowFlags: [.shown])

    window.setPosition(x: Int32.WindowPosition.centered, y: 0)

    let graphics = Graphics(window: window, renderer: renderer)

    var gameState = GameState(score: 450)

    let (windowX, windowY) = graphics.window.size

    gameState.player.position = V2(Double(windowX) / 2, Double(windowY) / 2)


    // MARK: - Persist

    var persisted = Persisted(graphics: graphics, gameState: gameState)

    let memory = UnsafeMutablePointer<Byte>(allocatingCapacity: sizeofValue(persisted))

    write(&persisted, to: memory)

    return memory
  } catch {

    log.info("ERROR: Encounted during initialization \(error)")
    return nil
  }
}
