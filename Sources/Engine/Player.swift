
struct Player {
  static let moveSpeed: Double = 100.0
  static let width: Double = 32.0
  var position: V2
  var facing: V2?

  var state: State = .idle

  var isMoving: Bool {
    guard case .moving(_) = state else { return false }
    return true
  }

  init(position: Vector2) {
    self.position = position
  }

  enum State {
    case idle
    case standing
    case moving(to: V2)
  }

  mutating func move(in direction: V2) {
    // TODO(vdka): check we can move in that direction.
    switch state {
    case .idle, .standing:
      facing = direction.normalized()
      state = .moving(to: position + facing! * Player.width)

    default:
      return
    }
  }

  mutating func updatePosition(timeDelta: Double) {
    guard case .moving(to: let destination) = state else { return }

    // if position is roughly equal to destination then stop moving
    guard destination != position else {
      state = .standing
      return
    }

    let distanceToTravel = Player.moveSpeed * timeDelta

    // ensure the distance we will travel is less than or equal to the distance to our destination.
    guard (destination - position).length >= distanceToTravel else {
      position = destination
      state = .standing
      return
    }

    position += facing! * distanceToTravel
  }
}
