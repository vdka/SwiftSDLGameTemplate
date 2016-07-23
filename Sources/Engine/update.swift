
import SDL
import CSDL2
import Shared

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

  // MARK: - Read KeyboardState

  if keyboard[.down] {
    gameState.yPos += 1
  }
  if keyboard[.up] {
    gameState.yPos -= 1
  }
  if keyboard[.right] {
    gameState.xPos += 1
  }
  if keyboard[.left] {
    gameState.xPos -= 1
  }

  if gameState.xPos < 0 {
    gameState.xPos = window.size.w
  }
  if gameState.xPos > window.size.w {
    gameState.xPos = 0
  }
  if gameState.yPos < 0 {
    gameState.yPos = window.size.h
  }
  if gameState.yPos > window.size.h {
    gameState.yPos = 0
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
  gameState.score = gameState.score &+ 1

  var newTick = SDL_GetTicks()

  let dTicks = newTick - newTick

  SDL_Delay(UInt32(1000.0 / 60.0 - Double(dTicks)))

  write(&window, &renderer, &gameState, &newTick, to: memory)

  return true
}

