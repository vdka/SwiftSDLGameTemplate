
import SDL

import func Darwin.C.exit

public var keyHandler: [((KeyboardEvent, inout GameState) -> Void)?] = Array(repeating: nil, count: Scancode.numScancodes)

typealias Keymap = [Scancode: (KeyboardEvent, inout GameState) -> Void]

/// will load keybindings from file into memory
func loadKeybindings(from file: String? = nil) {

  guard file == nil else { return } // TODO(vdka): File based keymaps

  for (scancode, handler) in defaultKeymap {
    keyHandler[numericCast(scancode.rawValue)] = handler
  }
}

func movePlayer(_ direction: V2) -> (KeyboardEvent, inout GameState) -> Void {

  return { keyEvent, gameState in

    switch keyEvent.keyState {
    case .down:
      return gameState.player.move(in: direction)

    case .up: // FIXME(vdka): Messy logic
      switch abs(direction.y) < abs(direction.x) {
      case true:
        gameState.player.acceleration.x = 0
      case false:
        gameState.player.acceleration.y = 0
      }
    }
  }
}

let defaultKeymap: [Scancode: (KeyboardEvent, inout GameState) -> Void] = [
  .w: movePlayer(.up),
  .s: movePlayer(.down),
  .a: movePlayer(.left),
  .d: movePlayer(.right),
  .c: { lastEvent, gameState in
    switch lastEvent.keyState {
    case .down:
      // avoid the creation of huge numbers
      guard gameState.player.velocity.length != 0 else {
        return
      }
      let drag = (1 / gameState.player.velocity.length) + 0.025
      gameState.player.applyDrag(drag, timeDelta: gameState.timer.delta)

    case .up:
      break
    }
  },
  .h: { keyEvent, gameState in

    guard case .up = keyEvent.keyState else { return }
    log.info("velocity \(gameState.player.velocity)")
    log.info("acceleration \(gameState.player.acceleration)")
  },
  .space: { _, _ in
    print("Spacing")
  },
  .escape: { (_, gameState: inout GameState) in
    gameState.shouldQuit = true
  }
]
