
import SDL
import CSDL2

public struct Graphics {

  public var window: Window
  public var renderer: Renderer
  public var frameCounter = FrameCounter()

  public init(window: Window, renderer: Renderer) {
    self.window = window
    self.renderer = renderer
  }
}

extension Graphics {

  public struct FrameCounter {

    public var frames: UInt32 = SDL_GetTicks()
    public var lastUpdateTick: UInt32 = 0
    /// update period in ms
    public var updateFrequency: UInt32 = 1000

    public mutating func update() -> UInt32? {

      let currentTick = SDL_GetTicks()
      guard currentTick > updateFrequency else { return nil }
      if currentTick - updateFrequency < lastUpdateTick {
        frames += 1
        return nil
      }

      // currentTick is less than 1 second ago.

      // TODO(vdka): make this a rolling average of the last n fps values
      defer {
        lastUpdateTick = currentTick
        frames = 0
      }
      return ((1000 / updateFrequency) * frames)
    }
  }
}
