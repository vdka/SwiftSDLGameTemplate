
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
    guard case .down = keyEvent.keyState else { return }
    return gameState.player.move(in: direction)
  }
}

let defaultKeymap: [Scancode: (KeyboardEvent, inout GameState) -> Void] = [
  .w: movePlayer(.up),
  .s: movePlayer(.down),
  .a: movePlayer(.left),
  .d: movePlayer(.right),
  .h: { (_, gameState: inout GameState) in
    print(gameState.player)
  },
  .space: { _ in
    print("Spacing")
  },
  .escape: { (_, gameState: inout GameState) in
    gameState.shouldQuit = true
  }
]
