
import SwiftPCG

extension UnsafeMutablePointer {

  func object<T>(at offset: Int) -> T {

    return UnsafePointer<T>(advanced(by: offset)).pointee
  }
}

public struct GameState {


  public init(from pointer: UnsafeMutablePointer<Void>) {

    self.score = pointer.object(at: 0)
  }

  public var score: Int
}

