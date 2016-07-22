
import CSDL2

extension SDL {

  public struct WindowFlag: SDLOptionSet {
    public init(rawValue: UInt32) { self.rawValue = rawValue }
    public let rawValue: UInt32

    public static let
      /// fullscreen window
      fullscreen         = 0x00000001 as WindowFlag,
      /// window usable with OpenGL context
      opengl             = 0x00000002 as WindowFlag,
      /// window is visible
      shown              = 0x00000004 as WindowFlag,
      /// window is not visible
      hidden             = 0x00000008 as WindowFlag,
      /// no window decoration
      borderless         = 0x00000010 as WindowFlag,
      /// window can be resized
      resizable          = 0x00000020 as WindowFlag,
      /// window is minimized
      minimized          = 0x00000040 as WindowFlag,
      /// window is maximized
      maximized          = 0x00000080 as WindowFlag,
      /// window has grabbed input focus
      inputGrabbed      = 0x00000100 as WindowFlag,
      /// window has input focus
      inputFocus        = 0x00000200 as WindowFlag,
      /// window has mouse focus
      mouseFocus        = 0x00000400 as WindowFlag,
      ///
      fullscreenDesktop = WindowFlag(rawValue: WindowFlag.fullscreen.rawValue | 0x00001000),
      /// window not created by SDL
      foreign            = 0x00000800 as WindowFlag,
      /// window should be created in high-DPI mode if supported
      allowHighdpi      = 0x00002000 as WindowFlag,
      /// window has mouse captured (unrelated to inputGrabbed
      mouseCapture      = 0x00004000 as WindowFlag
  }

//  func createWindowAndRenderer(width: Int32, height: Int32, windowFlags:

  public enum WindowEvent: UInt32 {
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

  public final class Window: Passthrough {
    public init() { self.pointer = nil }
    public var pointer: OpaquePointer?

    deinit {
      SDL_DestroyWindow(pointer)
    }
  }

  // TODO(vdka): shift this to the Window namespace
  /// NOTE - If creating a window this has the potential to return 0
}

extension SDL.Window {

  public static func create(titled title: String, x: Int32, y: Int32, w: Int32, h: Int32, flags: SDL.WindowFlag) -> SDL.Window {

    let window = SDL_CreateWindow(title, x, y, w, h, flags.rawValue)

    return SDL.Window(window)
  }

  public func setPosition(x: Int32, y: Int32) {

    SDL_SetWindowPosition(pointer, x, y)
  }

  public var size: (w: Int32, h: Int32) {

    var (w, h): (Int32, Int32) = (0, 0)
    SDL_GetWindowSize(pointer, &w, &h)
    return (w: w, h: h)
  }
}


// This can become a some form of Type maybe.
extension Int32 {

  public enum WindowPosition {


    /// To select a screen OR (|) this value with the screen number you wish to display on
    public static let undefined: Int32 = SDL_WINDOWPOS_UNDEFINED_MASK

    /// To select a screen OR (|) this value with the screen number you wish to display on
    public static let centered: Int32 = SDL_WINDOWPOS_CENTERED_MASK
  }
}

