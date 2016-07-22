
import SDL
import CSDL2

import Shared

// returns the intent to continue
@_silgen_name("loop")
func update(with memory: UnsafeMutablePointer<Byte>!) -> Bool {

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

