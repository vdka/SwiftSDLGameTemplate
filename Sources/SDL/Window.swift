
import CSDL2

//int SDL_CreateWindowAndRenderer	(	int 	width,
//                                	 	int 	height,
//                                	 	Uint32 	window_flags,
//                                	 	SDL_Window ** 	window,
//                                	 	SDL_Renderer ** 	renderer
//)

extension SDL {

  public struct WindowFlag: SDLOptionSet {
    public init(rawValue: UInt32) { self.rawValue = rawValue }
    public let rawValue: UInt32

    public static let
      timer           = 0x00000001 as WindowFlag,
      audio           = 0x00000010 as WindowFlag,
      video           = 0x00000020 as WindowFlag,
      joystick        = 0x00000200 as WindowFlag,
      haptic          = 0x00001000 as WindowFlag,
      gameController  = 0x00002000 as WindowFlag,
      events          = 0x00004000 as WindowFlag,
      noParachute     = 0x00100000 as WindowFlag
  }


//  func createWindowAndRenderer(width: Int32, height: Int32, windowFlags:
}
