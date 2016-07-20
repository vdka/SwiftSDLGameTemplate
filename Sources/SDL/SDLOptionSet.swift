
public protocol SDLOptionSet: OptionSet, IntegerLiteralConvertible {

  var rawValue: UInt32 { get }

  init(rawValue: UInt32)
}

extension SDLOptionSet {

  public init(integerLiteral: UInt32) {

    self.init(rawValue: integerLiteral)
  }
}
