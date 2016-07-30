
import CSDL2

public struct Window: Passthrough {
  public init() { self.pointer = nil }
  public var pointer: OpaquePointer?
}

extension Window {

  public struct Flag: SDLOptionSet {
    public init(rawValue: UInt32) { self.rawValue = rawValue }
    public let rawValue: UInt32

    public static let
      /// fullscreen window
      fullscreen         = 0x00000001 as Flag,
      /// window usable with OpenGL context
      opengl             = 0x00000002 as Flag,
      /// window is visible
      shown              = 0x00000004 as Flag,
      /// window is not visible
      hidden             = 0x00000008 as Flag,
      /// no window decoration
      borderless         = 0x00000010 as Flag,
      /// window can be resized
      resizable          = 0x00000020 as Flag,
      /// window is minimized
      minimized          = 0x00000040 as Flag,
      /// window is maximized
      maximized          = 0x00000080 as Flag,
      /// window has grabbed input focus
      inputGrabbed      = 0x00000100 as Flag,
      /// window has input focus
      inputFocus        = 0x00000200 as Flag,
      /// window has mouse focus
      mouseFocus        = 0x00000400 as Flag,
      ///
      fullscreenDesktop = Flag(rawValue: Flag.fullscreen.rawValue | 0x00001000),
      /// window not created by SDL
      foreign            = 0x00000800 as Flag,
      /// window should be created in high-DPI mode if supported
      allowHighdpi      = 0x00002000 as Flag,
      /// window has mouse captured (unrelated to inputGrabbed
      mouseCapture      = 0x00004000 as Flag
  }

//  func createWindowAndRenderer(width: Int32, height: Int32, windowFlags:

  public enum Event: UInt32 {
    /// Never used
    case none = 0x200
    /// Window has been shown
    case shown
    /// Window has been hidden
    case hidden
    /// Window has been exposed and should be redrawn
    case exposed
    /// Window has been moved to data1, data2
    case moved
    /// Window has been resized to data1xdata2
    case resized
    /// The window size has changed, either as a result of an API call or through the system or user changing the window size.
    case sizeChanged
    /// Window has been minimized
    case minimized
    /// Window has been maximized
    case maximized
    /// Window has been restored to normal size and position
    case restored
    /// Window has gained mouse focus
    case enter
    /// Window has lost mouse focus
    case leave
    /// Window has gained keyboard focus
    case focusGained
    /// Window has lost keyboard focus
    case focusLost
    /// The window manager requests that the window be closed
    case close
  }
}


// MARK: - Lifetime

extension Window {

  public static func create(titled title: String, x: Int32, y: Int32, w: Int32, h: Int32, flags: Flag) -> Window {

    let window = SDL_CreateWindow(title, x, y, w, h, flags.rawValue)

    return Window(window)
  }

  func destroy() {
    SDL_DestroyWindow(pointer)
  }
}


// MARK: - Rendering

extension Window {

  public func updateSurface() throws {
    let result = SDL_UpdateWindowSurface(pointer)
    guard result == 0 else { throw SDL.Error.last }
  }
}


// MARK: - Configuration

extension Window {

  public func setPosition(x: Int32, y: Int32) {

    SDL_SetWindowPosition(pointer, x, y)
  }

  public var rect: Rect {
    let (w, h) = size
    return Rect(x: 0, y: 0, w: w, h: h)
  }

  public var size: (w: Int32, h: Int32) {

    var (w, h): (Int32, Int32) = (0, 0)
    SDL_GetWindowSize(pointer, &w, &h)
    return (w: w, h: h)
  }
}


// TODO(vdka): This can become a some form of Type maybe.
extension Int32 {

  public enum WindowPosition {


    /// To select a screen OR (|) this value with the screen number you wish to display on
    public static let undefined: Int32 = SDL_WINDOWPOS_UNDEFINED_MASK

    /// To select a screen OR (|) this value with the screen number you wish to display on
    public static let centered: Int32 = SDL_WINDOWPOS_CENTERED_MASK
  }
}
