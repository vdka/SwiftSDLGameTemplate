
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

public struct SimpleKeyboard: OptionSet {

  public init(rawValue: UInt64) { self.rawValue = rawValue }
  public let rawValue: UInt64

  public static let
    a = 0b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0001 as SimpleKeyboard,
    b = 0b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0010 as SimpleKeyboard
}

extension SimpleKeyboard: IntegerLiteralConvertible {

  public init(integerLiteral: UInt64) {

    self.rawValue = integerLiteral
  }
}

