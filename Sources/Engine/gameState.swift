
public typealias Byte = UInt8

public struct GameState {

  public var score: Int

  public var shouldQuit: Bool = false

  public var player: Player

  public var timer: Timer = Timer()

  public init(score: Int) {

    self.score = score
    self.shouldQuit = false
    self.player = Player(position: .zero)
  }
}
