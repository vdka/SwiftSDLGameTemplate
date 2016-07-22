
public typealias Byte = UInt8

public struct GameState {

  public var score: Int

  public var xPos: Int32
  public var yPos: Int32

  public init(score: Int, xPos: Int32, yPos: Int32) {

    self.score = score
    self.xPos = xPos
    self.yPos = yPos
  }
}

extension GameState {

  public init(from pointer: UnsafeMutablePointer<Byte>) {

    var currentOffset = 0
    
    self.score = pointer.object(at: currentOffset)
    currentOffset += sizeofValue(score)

    self.xPos = pointer.object(at: currentOffset)
    currentOffset += sizeofValue(xPos)

    self.yPos = pointer.object(at: currentOffset)
    currentOffset += sizeofValue(yPos)
  }
}

