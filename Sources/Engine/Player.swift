
public struct Player {
  public static let moveSpeed: Double = 100.0
  public static let width: Double = 20.0
  public var width: Int = 20
  public var hight: Int = 20
  public var position: Vector2

  public var state: State = .idle

  public init(position: Vector2) {
    self.position = position
  }

  public enum State {
    case idle
    case standing
    case moving(to: V2)
  }

  public mutating func move(in direction: V2) {
    // TODO(vdka): check we can move in that direction.
    switch state {
    case .idle, .standing:
      state = .moving(to: position + direction.normalized() * Player.width)

    default:
      return
    }
  }

  public mutating func updatePosition(timeDelta: Double) {
    guard case .moving(to: let destination) = state else { return }

    guard destination != position else {
      state = .standing
      return
    }

    let distanceToTravel = Player.moveSpeed * timeDelta

    print("\((destination - position).length) <= \(distanceToTravel)")

    // ensure the distance we will travel is less than or equal to the distance to our destination.
    guard (destination - position).length >= distanceToTravel else {
      print("arrived")
      position = destination
      return
    }

    print("still travelling")
    position += (destination - position).normalized() * distanceToTravel
  }
}
