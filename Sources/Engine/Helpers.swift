
import SDL

typealias AssetData = (Texture)

/// Used to persist things between calls to the update function when using dynamic code reload.
struct Persisted {
  var graphics: Graphics
  var gameState: GameState
  var assetData: AssetData

  init(graphics: Graphics, gameState: GameState, assetData: AssetData) {
    self.graphics = graphics
    self.gameState = gameState
    self.assetData = assetData
  }

  mutating func persist(to memory: UnsafeMutablePointer<Byte>!) {

    write(&self, to: memory)
  }
}

/// Handles deserialization of memory into typed Persisted states.
func call<T>(with memory: UnsafeMutablePointer<Byte>!, _ function: (inout GameState, inout Graphics, AssetData) -> T) -> T {

  var persisted = UnsafeMutablePointer<Persisted>(memory).pointee

  let result = function(&persisted.gameState, &persisted.graphics, persisted.assetData)

  write(&persisted, to: memory)

  return result
}
