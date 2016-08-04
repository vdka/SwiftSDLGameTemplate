
import CSDL2
import SDL

let baseDir = "/" + Array(#file.characters.split(separator: "/").dropLast(3)).map(String.init).joined(separator: "/")

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

    let texture = try Texture.loadBMP(from: baseDir + "/assets/red.bmp", for: renderer)

    // MARK: - Persist

    var persisted = Persisted(graphics: graphics, gameState: gameState, assetData: (texture))

    let memory = UnsafeMutablePointer<Byte>(allocatingCapacity: sizeofValue(persisted))

    persisted.persist(to: memory)

    return memory
  } catch {

    log.info("ERROR: Encounted during initialization \(error)")
    return nil
  }
}
