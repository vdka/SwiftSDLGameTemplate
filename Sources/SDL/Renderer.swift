
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
  }

  public static func createRenderer(forWindow window: Window, indexOfDriver: Int32 = -1, flags: RendererFlag = .accelerated) -> Renderer {

    let renderer = SDL_CreateRenderer(window.pointer, indexOfDriver, flags.rawValue)

    return Renderer(renderer)
  }
}
