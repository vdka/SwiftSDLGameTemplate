
import SDL

public struct Graphics {

  public var window: Window
  public var renderer: Renderer

  public init(window: Window, renderer: Renderer) {
    self.window = window
    self.renderer = renderer
  }
}
