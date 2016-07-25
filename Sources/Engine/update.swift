
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

  var timer: Timer = memory.object(at: currentOffset)
  currentOffset += sizeofValue(gameState)

  defer {
    do {
      try render(gameState, to: window, with: renderer)

      print("frame took \(timer.delta)ms")
      timer.touch()

      print("delaying next frame by \(max(1000 / 60 - timer.delta, 0))")

      SDL_Delay(UInt32(max(1000 / 60 - timer.delta, 0)))
      timer.touch()
      write(&window, &renderer, &gameState, &timer, to: memory)
    } catch { print("ERROR: during rendering \(error)") }
  }


  // MARK: - Handle input
  gameState = keyboard.downKeys.reduce(gameState) { gameState, key in
    return keyboardHandler[key]?(gameState) ?? gameState
  }

  // TODO(vdka): shift this
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

  var event = SDL_Event()
  SDL_PollEvent(&event)

  switch event.type {
  case SDL_QUIT.rawValue:
    print("quitting")
    return false

  default:
    break
  }

  return true // continue
}

