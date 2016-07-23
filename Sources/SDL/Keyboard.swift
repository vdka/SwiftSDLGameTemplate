
import CSDL2

// TODO(vdka): This API is clunky not sure why we can't do static subscripts but that was my initial thought.
//  Maybe this should be one of those dirty global variables
public struct Keyboard {

  public init() {}

  public subscript(_ keyCode: Scancode) -> Bool {

    return SDL_GetKeyboardState(nil).advanced(by: numericCast(keyCode.rawValue)).pointee > 0
  }
}

// EW.
public var keyboard: Keyboard {

  return Keyboard()
}

extension Keyboard {

  public func contains(_ member: Scancode) -> Bool {
    return SDL_GetKeyboardState(nil).advanced(by: numericCast(member.rawValue)).pointee > 0
  }

  public func contains(_ members: [Scancode]) -> Bool {

    for member in members {
      guard SDL_GetKeyboardState(nil).advanced(by: numericCast(member.rawValue)).pointee > 0 else {
        return false
      }
    }
    return true
  }
}

