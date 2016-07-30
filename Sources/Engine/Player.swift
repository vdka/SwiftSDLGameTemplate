
public struct Player {
  public static let moveSpeed: Double = 1.0
  public var width: Int = 20
  public var hight: Int = 20
  public var position: Vector2
  public var velocity: Vector2 = .zero
  public var acceleration: Vector2 = .zero

  public init(position: Vector2, velocity: Vector2 = .zero, acceleration: Vector2 = .zero) {
    self.position = position
    self.velocity = velocity
    self.acceleration = acceleration
  }

  public mutating func move(in direction: V2) {

    // negate y as the window
    acceleration += direction.normalized() * Player.moveSpeed

    // Cap acceleration to 100 units/s
    if acceleration.length > 100 {
      // TODO(vdka): optimize
      acceleration = acceleration.normalized() * 100
    }
  }

  public mutating func updateVelocity(timeDelta: Double) {
    velocity += acceleration * timeDelta
  }

  public mutating func updatePosition(timeDelta: Double) {
    position += velocity * timeDelta
  }

  public mutating func applyDrag(_ amount: Double, timeDelta: Double) {
    guard velocity.length > 1 else {
      velocity = .zero
      return
    }
    let drag = -(velocity) * amount
    assert(drag.length < velocity.length, "We applied so much drag we went backwards.")
    velocity += drag
  }
}
