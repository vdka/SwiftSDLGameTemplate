
import CSDL2
import SDL

/// Only ever called once when the game is first launched. Use this to set up a state that can be persisted to Raw Memory between reloads of libGameEngine.dylib
@_silgen_name("load")
public func initialize() -> UnsafeMutablePointer<Byte>? {

  defer { loadConfiguration() }

  do {

    // MARK: - Setup
    try SDL.initialize(components: .video)

    // let (window, renderer) = try SDL.createWindowAndRenderer(w: 360, h: 360, windowFlags: [.shown, .presentVsync])
    let window = Window.create(titled: "SwiftSDLTemplate", x: 0, y: 0, w: 360, h: 360, flags: [.shown])
    let renderer = Renderer.create(for: window, flags: [.presentVsync])

    window.setPosition(x: Int32.WindowPosition.centered, y: 0)

    let graphics = Graphics(window: window, renderer: renderer)

    var gameState = GameState(score: 450)

    let (windowX, windowY) = graphics.window.size

    gameState.player.position = V2(Double(windowX) / 2, Double(windowY) / 2)

    let characterSpriteSheet = try SpriteSheet(path: "/assets/red.bmp", spriteDimentions: V2(64, 64), for: renderer)

    // MARK: - Persist

    var persisted = Persisted(graphics: graphics, gameState: gameState, assetData: (characterSpriteSheet))

    let memory = UnsafeMutablePointer<Byte>(allocatingCapacity: sizeofValue(persisted))

    persisted.persist(to: memory)

    return memory
  } catch {

    log.info("ERROR: Encounted during initialization \(error)")
    return nil
  }
}
