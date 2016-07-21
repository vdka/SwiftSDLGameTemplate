
import CSDL2

extension SDL {

  public static func createWindowAndRenderer(w: Int32, h: Int32, windowFlags: WindowFlag) throws -> (Window, Renderer) {

    let window = Window()
    let renderer = Renderer()
    let success = SDL_CreateWindowAndRenderer(w, h, windowFlags.rawValue, &window.pointer, &renderer.pointer)
    guard success == 0 else { throw Error.last }
    return (window, renderer)
  }
}

public protocol SDLOptionSet: OptionSet, IntegerLiteralConvertible {

  var rawValue: UInt32 { get }

  init(rawValue: UInt32)
}

extension SDLOptionSet {

  public init(integerLiteral: UInt32) {

    self.init(rawValue: integerLiteral)
  }
}

public protocol Passthrough: class, NilLiteralConvertible {

  init()
  var pointer: OpaquePointer? { get set }
}

extension Passthrough {

  public init(nilLiteral: ()) {
    self.init()
  }

  public init(_ pointer: OpaquePointer?) {
    self.init()
    self.pointer = pointer
  }
}
