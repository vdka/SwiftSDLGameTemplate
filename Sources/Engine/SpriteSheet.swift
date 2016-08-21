
import SDL

struct SpriteSheet {

  /// The path to load the texture from (can be used to reload textures when needed)
  let path: String

  /// The dimentions of individual sprites
  let spriteDimentions: V2

  // FIXME(vdka): I don't like this. Maybe isn't the most logical place for it.
  var lastFrame: Int = 0

  var texture: Texture

  init(path: String, spriteDimentions: V2, for renderer: Renderer) throws {
    self.path = path
    self.spriteDimentions = spriteDimentions
    self.texture = try Texture.loadBMP(from: baseDir + path, for: renderer)
  }

  func getSpriteRect(for position: V2) -> Rect {
    return Rect(origin: V2(spriteDimentions.x * position.x, spriteDimentions.y * position.y), size: spriteDimentions)
  }
}
