
import SwiftPCG

public typealias Byte = UInt8

public struct GameState {

  public var score: Int

  public init(score: Int) {

    self.score = score
  }
}

extension GameState {

  public init(from pointer: UnsafeMutablePointer<Byte>) {

    self.score = pointer.object(at: 0)
  }

  public mutating func write(to destinationPointer: UnsafeMutablePointer<Byte>) {

    let nBytes = sizeofValue(self)

    print("size of GameState: \(sizeofValue(self))")

    withUnsafePointer(&self) {

      let valuePointer = unsafeBitCast($0, to: UnsafePointer<Byte>.self)
      for byteOffset in 0..<nBytes {
        destinationPointer.advanced(by: byteOffset).pointee = valuePointer.advanced(by: byteOffset).pointee
      }
    }
  }
}

extension UnsafeMutablePointer {

  func object<T>(at offset: Int) -> T {

    return UnsafePointer<T>(self.advanced(by: offset)).pointee
  }
}

