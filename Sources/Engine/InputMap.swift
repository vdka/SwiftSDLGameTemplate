
import SDL
import Shared

import func Darwin.C.exit

extension GameState {
  enum Direction {
    case up, down, left, right
  }
  func move(_ direction: Direction) -> GameState {
    var gameState = self
    switch direction {
    case .up: gameState.yPos -= 1
    case .down: gameState.yPos += 1
    case .left: gameState.xPos -= 1
    case .right: gameState.xPos += 1
    }
    return gameState
  }
}

public let keyboardHandler: [Scancode: (GameState) -> GameState] = [
  .w: { return $0.move(.up) },
  .s: { return $0.move(.down) },
  .a: { return $0.move(.left) },
  .d: { return $0.move(.right) },
  .space: { print("Hello"); return $0 },
  .escape: { exit(0); return $0 }
]

