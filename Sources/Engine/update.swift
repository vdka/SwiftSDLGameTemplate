
import SDL
import CSDL2

// returns the intent to continue
@_silgen_name("update")
public func update(with memory: UnsafeMutablePointer<Byte>!) -> Bool {

  var currentOffset = 0

  var graphics: Graphics = memory.object(at: currentOffset)
  currentOffset += sizeofValue(graphics)

  var gameState: GameState = memory.object(at: currentOffset)
  currentOffset += sizeofValue(gameState)

  update(&gameState, using: &graphics)

  write(&graphics, &gameState, &gameState.timer, to: memory)

  return gameState.shouldQuit
}

public func update(_ gameState: inout GameState, using graphics: inout Graphics) {

  defer {
    do {
      try render(gameState, to: graphics.window, with: graphics.renderer)

      // TODO(vdka): FPS counting
//      print("frame took \(gameState.timer.delta)ms")
      gameState.timer.touch()

      var frameCounter = graphics.frameCounter
      let framesPerSecond = graphics.frameCounter.update()
      if let framesPerSecond = framesPerSecond {
        print("fps: \(framesPerSecond)")
      }
      // print("delaying next frame by \(max(1000 / 60 - timer.delta, 0))")

      // SDL_Delay(UInt32(max(1000 / 60 - timer.delta, 0)))
    } catch { print("ERROR: during rendering \(error)") }
  }

  // MARK: - Handle input
  gameState.shouldQuit = Keyboard.update()

  for keyEvent in Keyboard.keyEvents {
    let keyIndex: Int = numericCast(keyEvent.keysym.scancode.rawValue)
    keyHandler[keyIndex]?(keyEvent, &gameState)
  }

  gameState.player.updatePosition(timeDelta: gameState.timer.delta)
  gameState.player.updateVelocity(timeDelta: gameState.timer.delta)
  gameState.player.applyDrag(0.001, timeDelta: gameState.timer.delta)

  // TODO(vdka): shift this
  if gameState.player.position.x < 0 {
    gameState.player.position.x = Double(graphics.window.size.w)
  }
  if gameState.player.position.x > Double(graphics.window.size.w) {
    gameState.player.position.x = 0
  }
  if gameState.player.position.y < 0 {
    gameState.player.position.y = Double(graphics.window.size.h)
  }
  if gameState.player.position.y > Double(graphics.window.size.h) {
    gameState.player.position.y = 0
  }
}
