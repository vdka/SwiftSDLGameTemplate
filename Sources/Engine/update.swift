
import SDL
import CSDL2

// returns shouldQuit
@_silgen_name("update")
public func update(with memory: UnsafeMutablePointer<Byte>!) -> Bool {

  return call(with: memory, update)
}

// returns shouldQuit
func update(_ gameState: inout GameState, using graphics: inout Graphics, assetData: AssetData) -> Bool {

  defer {
    do {
      try render(gameState, to: graphics, with: assetData)

      // print("timer.delta \(gameState.timer.delta)")
      gameState.timer.touch()

      var frameCounter = graphics.frameCounter
      let framesPerSecond = graphics.frameCounter.update()
      if let framesPerSecond = framesPerSecond {
        log.info("\(framesPerSecond) fps")
      }

      // print("delaying next frame by \(max(1000 / 60 - timer.delta, 0))")

      // TODO(vdka): This delay should lock to 60 fps. it's instead hitting 53? Could be an error in the FPS counter
      // NOTE(vdka): Perhaps SDL can handle this for us also. If so we should check.
      if graphics.config.vsync {
        SDL_Delay(UInt32(max(1000 / graphics.config.fpsTarget - gameState.timer.delta, 0)))
      }

      #if DEBUG
        _ = Darwin.fflush(Darwin.stdout) // flush stdout ignore failure
      #endif
    } catch { log.error("during rendering \(error)") }
  }

  // MARK: - Handle input
  gameState.shouldQuit = Keyboard.update()

  for keyEvent in Keyboard.keyEvents {
    let keyIndex: Int = numericCast(keyEvent.keysym.scancode.rawValue)
    keyHandler[keyIndex]?(keyEvent, &gameState)
  }

  gameState.player.updatePosition(timeDelta: gameState.timer.delta)

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

  return gameState.shouldQuit
}
