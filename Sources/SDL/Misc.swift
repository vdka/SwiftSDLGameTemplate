
import CSDL2

extension SDL {

  public enum HitTestResult: UInt32 {
    case normal = 0
    case draggable
    case resizeTopLeft, resizeTop, resizeTopRight
    case resizeLeft, resizeRight
    case resizeBottomLeft, resizeBottom, resizeBttomRight
  }

  public struct MessageBoxButtonFlag: SDLOptionSet {
    public init(rawValue: UInt32) { self.rawValue = rawValue }
    public let rawValue: UInt32

    public static let
      returnKeyDefault = 0b01 as MessageBoxButtonFlag,
      escapeKeyDefault = 0b10 as MessageBoxButtonFlag
  }
}
