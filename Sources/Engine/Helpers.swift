
/// Used to persist things between calls to the update function when using dynamic code reload.
struct Persisted {
  var graphics: Graphics
  var gameState: GameState

  init(graphics: Graphics, gameState: GameState) {
    self.graphics = graphics
    self.gameState = gameState
  }
}

/// Handles deserialization of memory into typed Persisted states.
func call<T>(with memory: UnsafeMutablePointer<Byte>!, _ function: (inout GameState, inout Graphics) -> T) -> T {

  var persisted = UnsafeMutablePointer<Persisted>(memory).pointee

  let result = function(&persisted.gameState, &persisted.graphics)

  write(&persisted, to: memory)

  return result
}
