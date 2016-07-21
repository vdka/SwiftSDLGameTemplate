
import CSDL2

extension SDL {

  public enum BlendingMode: UInt32 {
    case none = 0
    case alpha
    case additive
    case modulate
  }
}
