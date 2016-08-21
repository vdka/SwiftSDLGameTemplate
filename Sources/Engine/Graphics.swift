
import SDL
import CSDL2

struct Graphics {

  var window: Window
  var renderer: Renderer

  var frameCounter = FrameCounter()

  var config = Config()

  init(window: Window, renderer: Renderer) {
    self.window = window
    self.renderer = renderer
  }
}

extension Graphics {

  struct Config {

    var vsync: Bool = true
    var fpsTarget: Double = 60
  }
}

extension Graphics {

  struct FrameCounter {

    var frames: UInt32 = SDL_GetTicks()
    var lastUpdateTick: UInt32 = 0
    /// update period in ms
    var updateFrequency: UInt32 = 1000

    mutating func update() -> Double? {

      let currentTick = SDL_GetTicks()
      guard currentTick > updateFrequency else { return nil }
      if currentTick - updateFrequency <= lastUpdateTick {
        frames += 1
        return nil
      }

      // currentTick is less than 1 second ago.

      // TODO(vdka): make this a rolling average of the last n fps values
      defer {
        lastUpdateTick = currentTick
        frames = 0
      }
      return Double((1000 / Double(updateFrequency)) * Double(frames))
    }
  }
}
