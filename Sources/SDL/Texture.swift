
import CSDL2

public struct Texture: Passthrough {
  public init() { self.pointer = nil }
  public var pointer: OpaquePointer?
}

extension Texture {

  public enum TextureAccess: UInt32 {
    case `static` = 0
    case streaming
    case target
  }

  public enum TextureModulate: UInt32 {
    case none = 0
    case color
    case alpha
  }
}

extension Texture {

  public static func loadBMP(from path: String, for renderer: Renderer) throws -> Texture {

    let loadedSurface = SDL_LoadBMP_RW(SDL_RWFromFile(path, "rb"), 1)
    guard loadedSurface != nil else { throw SDL.Error.last }

    let texture = SDL_CreateTextureFromSurface(renderer.pointer, loadedSurface)

    SDL_FreeSurface(loadedSurface)

    return Texture(texture)
  }
}


extension Renderer {

  public func copy(texture: Texture, sourceRect: Rect? = nil, destRect: Rect? = nil) throws {
    let result: Int32
    switch (sourceRect, destRect) {
    case var (sourceRect?, destRect?):
      result = SDL_RenderCopy(pointer, texture.pointer, &sourceRect, &destRect)

    case var (sourceRect?, nil):
      result = SDL_RenderCopy(pointer, texture.pointer, &sourceRect, nil)

    case var (nil, destRect?):
      result = SDL_RenderCopy(pointer, texture.pointer, nil, &destRect)

    case (nil, nil):
      result = SDL_RenderCopy(pointer, texture.pointer, nil, nil)
    }
    guard result == 0 else { throw SDL.Error.last }
  }
}
