
import CSDL2

extension SDL {

  public struct RendererFlag: SDLOptionSet {
    public init(rawValue: UInt32) { self.rawValue = rawValue }
    public let rawValue: UInt32

    public static let
      software      = 0b0001 as RendererFlag,
      accelerated   = 0b0010 as RendererFlag,
      presentVsync  = 0b0100 as RendererFlag,
      targetTexture = 0b1000 as RendererFlag
  }

  public enum TextureAccess: UInt32 {
    case `static` = 0
    case streaming
    case target
  }

  public enum TextureModulate: UInt32 {
    case none = 0
    case color
    case alpha
  }

  public struct Texture {
    var pointer: OpaquePointer?
  }

  public final class Renderer: Passthrough {
    public init() { self.pointer = nil }
    public var pointer: OpaquePointer?

    deinit {
      SDL_DestroyRenderer(pointer)
    }
  }
}

extension SDL.Renderer {

  public static func create(forWindow window: SDL.Window, indexOfDriver: Int32 = -1, flags: SDL.RendererFlag = .accelerated) -> SDL.Renderer {

    let renderer = SDL_CreateRenderer(window.pointer, indexOfDriver, flags.rawValue)

    return SDL.Renderer(renderer)
  }

  public func drawLine(x1: Int32, y1: Int32, x2: Int32, y2: Int32) throws {

    let result = SDL_RenderDrawLine(pointer, x1, y1, x2, y2)

    guard result == 0 else { throw SDL.Error.last }
  }
}

