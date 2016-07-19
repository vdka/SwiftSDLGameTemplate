
import CSDL2

// returns the intent to continue
@_silgen_name("gameUpdate")
func update(with state: UnsafeMutablePointer<Void>, event: SDL_Event?) -> Bool {

  if let event = event {
    switch event.type {
    case SDL_QUIT.rawValue:
      print("quitting")
      return false

    case SDL_KEYDOWN.rawValue where event.key.keysym.sym == numericCast(SDLK_ESCAPE):
      print("escaping")
      return false

    case SDL_KEYDOWN.rawValue where event.key.keysym.sym == numericCast(SDLK_SPACE):
      print("Spacing out")

    default:
      break
    }
  }

  return true
}

