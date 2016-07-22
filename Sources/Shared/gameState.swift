
import SwiftPCG

public struct GameState {

  public var score: Int

  public init(from pointer: UnsafeMutablePointer<Void>) {

    self.score = pointer.object(at: 0)
  }

  public init(score: Int) {

    self.score = score
  }
}

extension UnsafeMutablePointer {

  func object<T>(at offset: Int) -> T {

    return UnsafePointer<T>(advanced(by: offset)).pointee
  }
}

