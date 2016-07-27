
import CSDL2

extension SDL {

  public struct Error: Swift.Error {
    public var message: String

    public static var last: Error {
      defer { SDL_ClearError() }

      return Error(message: String(cString: SDL_GetError()))
    }
  }
}
