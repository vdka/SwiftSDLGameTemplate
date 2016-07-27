
import SDL

import func Darwin.C.exit

public var keyHandler: [((KeyboardEvent, inout GameState) -> Void)?] = Array(repeating: nil, count: Scancode.numScancodes)

typealias Keymap = [Scancode: (KeyboardEvent, inout GameState) -> Void]

/// will load keybindings from file into
func loadKeybindings(from file: String? = nil) {

  guard file == nil else { return } // TODO(vdka): File based keymaps

  for (scancode, handler) in defaultKeymap {
    keyHandler[numericCast(scancode.rawValue)] = handler
  }
}

let defaultKeymap: [Scancode: (KeyboardEvent, inout GameState) -> Void] = [
  .w: { lastEvent, gameState in
    switch lastEvent.keyState {
    case .down:
      gameState.player.move(in: .up)

    case .up:
      gameState.player.acceleration.y = 0
    }
  },
  .s: { lastEvent, gameState in
    switch lastEvent.keyState {
    case .down:
      gameState.player.move(in: .down)

    case .up:
      gameState.player.acceleration.y = 0
    }
  },
  .a: { lastEvent, gameState in
    switch lastEvent.keyState {
    case .down:
      gameState.player.move(in: .left)

    case .up:
      gameState.player.acceleration.x = 0
    }
  },
  .d: { lastEvent, gameState in
    switch lastEvent.keyState {
    case .down:
      gameState.player.move(in: .right)

    case.up:
      gameState.player.acceleration.x = 0
    }
  },
  .c: { lastEvent, gameState in
    switch lastEvent.keyState {
    case .down:
      // TODO(vdka): timeDelta?
      gameState.player.applyDrag(0.05, timeDelta: 0.01)
    default: break
    }
  },
  .space: { _, _ in
    print("Hello")
  },
  .escape: { (_, gameState: inout GameState) in
    gameState.shouldQuit = true
  }
]
