
import CSDL2

public typealias KeyboardEvent = SDL_KeyboardEvent

extension KeyboardEvent {

  public enum KeyState {
    case up, down
  }

  public var keyState: KeyState {
    if type == SDL_KEYDOWN.rawValue {
      return .down
    } else if type == SDL_KEYUP.rawValue {
      return .up
    } else { fatalError("Expected a keyEvent type") }
  }
}

public enum Keyboard {

  // TODO(vdka): This needs to be more general and buffer every event type.
  public static var keyEvents: [KeyboardEvent] {
    return zip(downEvents, upEvents).flatMap {
      let (downEvent, upEvent) = $0
      switch (downEvent, upEvent) {
      case let (downEvent?, nil): return downEvent
      case let (nil, upEvent?): return upEvent
      case (nil, nil): return nil
      case (.some(_), .some(_)): fatalError("You broke your keyboard. A key is both up and down.")
      }
    }
  }

  public static var upEvents:   [KeyboardEvent?] = Array(repeating: nil, count: Scancode.numScancodes)

  public static var downEvents: [KeyboardEvent?] = Array(repeating: nil, count: Scancode.numScancodes)

  // public static var downKeys: [Bool] = Array(repeating: false, count: Scancode.numScancodes)

  // TODO(vdka): This needs to be more general and buffer every event type.
  public static func update() -> Bool {

    upEvents.enumerated()
      .filter { $0.1 != nil }
      .forEach { upEvents[$0.0] = nil }

    var event = Event()

    while SDL_PollEvent(&event) == 1 {

      guard event.type != SDL_QUIT.rawValue else { return true }

      // filters the non key events
      guard event.isKeyUp || event.isKeyDown else { continue }

      guard let scancode = Scancode(rawValue: numericCast(event.key.keysym.scancode.rawValue)) else { continue }

      let index: Int = numericCast(scancode.rawValue)

      switch event.key.keyState {
      case .down:
        downEvents[index] = event.key
        upEvents[index]   = nil

      case .up:
        downEvents[index] = nil
        upEvents[index]   = event.key
      }
    }

    return false
  }
}
