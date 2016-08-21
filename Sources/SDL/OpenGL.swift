
// TODO(vkda): https://wiki.libsdl.org/SDL_GLattr

import CSDL2

public enum SwapInterval: Int32 {
  case late = -1
  case immediate = 0
  case synchronized = 1
}

extension SDL {

  public enum OpenGL {

    public static func setSwapInterval(_ interval: SwapInterval) throws {

      let result = SDL_GL_SetSwapInterval(interval.rawValue)

      guard result == 0 else { throw SDL.Error.last }
    }
  }
}
