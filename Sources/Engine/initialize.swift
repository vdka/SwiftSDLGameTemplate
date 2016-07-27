
import CSDL2
import SDL
import Shared

/// Only ever called once when the game is first launched. Use this to set up a state that can be persisted to Raw Memory between reloads of libGameEngine.dylib
@_silgen_name("load")
public func initialize() -> UnsafeMutablePointer<Byte>? {

  do {

    try SDL.initialize(components: .video)

    let (window, renderer) = try SDL.createWindowAndRenderer(w: 360, h: 360, windowFlags: [.shown])

    window.setPosition(x: Int32.WindowPosition.centered, y: 0)

    var graphics = Graphics(window: window, renderer: renderer)

    var gameState = GameState(score: 450)

    var timer = Timer()

    // NOTE(vdka): If ever running into memory issues this is likely why. Make absolutely sure this is the amount of memory you need.
    let totalMemoryRequired = sizeofValue(graphics) + sizeofValue(gameState) + sizeofValue(timer)

    let memory = UnsafeMutablePointer<Byte>(allocatingCapacity: totalMemoryRequired)

    write(&graphics, &gameState, &timer, to: memory)

    return memory
  } catch {

    print("ERROR: Encounted during initialization \(error)")
    return nil
  }
}

/// Called every time the libGameEngine.dylib is reloaded. Use this to reload anything in the Engine that loaded after first load
@_silgen_name("onLoad")
public func reinitialize() {

  loadKeybindings()
}

// TODO(vdka): Dynamic reinitalize. Basically reinit any static var's eg keymaps.
