
import CSDL2

// Used to namespace static functions.
public enum SDL {}

extension SDL {

  public struct Component: SDLOptionSet {
    public init(rawValue: UInt32) { self.rawValue = rawValue }
    public let rawValue: UInt32

    public static let
      timer           = 0x00000001 as Component,
      audio           = 0x00000010 as Component,
      video           = 0x00000020 as Component,
      joystick        = 0x00000200 as Component,
      haptic          = 0x00001000 as Component,
      gameController  = 0x00002000 as Component,
      events          = 0x00004000 as Component,
      noParachute     = 0x00100000 as Component,
      everything      = [timer, audio, video, joystick, haptic, gameController, events] as Component
  }

  public static func initialize(components: Component) throws {

    let wasError = SDL_Init(components.rawValue)
    guard wasError == 0 else { throw Error.last }
  }

  /// Returns the set of initialized SDL components
  public static var intitialized: Component {
    return Component(rawValue: SDL_WasInit(Component.everything.rawValue))
  }

  public static func quit() {
    SDL_Quit()
  }
}
