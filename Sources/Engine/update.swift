
import SDL
import CSDL2
import Shared
import Renderer

// returns the intent to continue
@_silgen_name("update")
public func update(with memory: UnsafeMutablePointer<Byte>!) -> Bool {

  var currentOffset = 0

  var window: Window = memory.object(at: currentOffset)
  currentOffset += sizeofValue(window)

  var renderer: Renderer = memory.object(at: currentOffset)
  currentOffset += sizeofValue(renderer)

  var gameState: GameState = memory.object(at: currentOffset)
  currentOffset += sizeofValue(gameState)

  var lastTick: UInt32 = memory.object(at: currentOffset)
  currentOffset += sizeofValue(gameState)

  defer {
    do { try render(gameState, to: window, with: renderer) } catch { print("ERROR: during rendering \(error)") }
  }

  var event = SDL_Event()
  SDL_PollEvent(&event)

  if SDL_KEYDOWN.rawValue == event.type && event.key.keysym.sym == numericCast(SDLK_DOWN) {
    gameState.yPos += 1
  }
  if SDL_KEYDOWN.rawValue == event.type && event.key.keysym.sym == numericCast(SDLK_UP) {
    gameState.yPos -= 1
  }
  if SDL_KEYDOWN.rawValue == event.type && event.key.keysym.sym == numericCast(SDLK_RIGHT) {
    gameState.xPos += 1
  }
  if SDL_KEYDOWN.rawValue == event.type && event.key.keysym.sym == numericCast(SDLK_LEFT) {
    gameState.xPos -= 1
  }

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

  // TODO(vdka): proper frame syncronization
  SDL_Delay(32) // ~ 30 fps

  if gameState.score % 100 == 0 { print(gameState) }

  gameState.score = gameState.score &+ 1

  write(&window, &renderer, &gameState, to: memory)

  return true
}

