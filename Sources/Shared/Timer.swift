
import CSDL2

public struct Timer {

  var then: UInt64
  var now: UInt64
  var frequency: Double
  public var delta: Double {
    return Double(now - then) / Double(frequency)
  }

  public init() {
    self.now = SDL_GetPerformanceCounter()
    self.then = now
    self.frequency = Double(SDL_GetPerformanceFrequency())
  }

  public mutating func touch() {
    then = now
    now = SDL_GetPerformanceCounter()
  }
}

