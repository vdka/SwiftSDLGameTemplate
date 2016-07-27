
import CSDL2

public typealias Event = SDL_Event

extension Event {

  public var isKeyDown: Bool {
    return type == SDL_KEYDOWN.rawValue
  }

  public var isKeyUp: Bool {
    return type == SDL_KEYUP.rawValue
  }
}
