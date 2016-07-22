
import SDL
import CSDL2

import Shared

@_silgen_name("initialize")
func initialize() -> UnsafeMutablePointer<Void>? {

  var gameState = GameState(score: 450)

  return withUnsafeMutablePointer(&gameState) { UnsafeMutablePointer<Void>($0) }
}

// returns the intent to continue
@_silgen_name("loop")
func update(with memory: UnsafeMutablePointer<Void>!) -> Bool {

  let gameState = GameState(from: memory)

  //defer { render(with: memory) }

  //if let event = event {
  //  switch event.type {
  //  case SDL_QUIT.rawValue:
  //    print("quitting")
  //    return false

  //  case SDL_KEYDOWN.rawValue where event.key.keysym.sym == numericCast(SDLK_ESCAPE):
  //    print("escaping")
  //    return false

  //  case SDL_KEYDOWN.rawValue where event.key.keysym.sym == numericCast(SDLK_SPACE):
  //    print("Spacing out")

  //  default:
  //    break
  //  }
  //}

  SDL_Delay(1000)

  print(gameState)

  return true
}

