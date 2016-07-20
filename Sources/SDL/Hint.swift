
import CSDL2

extension SDL {

  public enum Hint: String {

    case accelerometerAsJoystick = "ACCELEROMETER_AS_JOYSTICK"
    case androidApkExpansionMainFileVersion = "ANDROID_APK_EXPANSION_MAIN_FILE_VERSION"
    case androidApkExpansionPatchFileVersion = "ANDROID_APK_EXPANSION_PATCH_FILE_VERSION"
    case androidSeparateMouseAndTouch = "ANDROID_SEPARATE_MOUSE_AND_TOUCH"
    case emscriptenKeyboardElement = "EMSCRIPTEN_KEYBOARD_ELEMENT"
    case framebufferAcceleration = "FRAMEBUFFER_ACCELERATION"
    case gamecontrollerconfig = "GAMECONTROLLERCONFIG"
    case grabKeyboard = "GRAB_KEYBOARD"
    case idleTimerDisabled = "IDLE_TIMER_DISABLED"
    case imeInternalEditing = "IME_INTERNAL_EDITING"
    case joystickAllowBackgroundEvents = "JOYSTICK_ALLOW_BACKGROUND_EVENTS"
    case macBackgroundApp = "MAC_BACKGROUND_APP"
    case macCtrlClickEmulateRightClick = "MAC_CTRL_CLICK_EMULATE_RIGHT_CLICK"
    case macMouseFocusClickthrough = "MAC_MOUSE_FOCUS_CLICKTHROUGH"
    case mouseRelativeModeWarp = "MOUSE_RELATIVE_MODE_WARP"
    case noSignalHandlers = "NO_SIGNAL_HANDLERS"
    case orientations = "ORIENTATIONS"
    case renderDirect3d11Debug = "RENDER_DIRECT3D11_DEBUG"
    case renderDirect3dThreadsafe = "RENDER_DIRECT3D_THREADSAFE"
    case renderDriver = "RENDER_DRIVER"
    case renderOpenglShaders = "RENDER_OPENGL_SHADERS"
    case renderScaleQuality = "RENDER_SCALE_QUALITY"
    case renderVsync = "RENDER_VSYNC"
    case threadStackSize = "THREAD_STACK_SIZE"
    case timerResolution = "TIMER_RESOLUTION"
    case videoAllowScreensaver = "VIDEO_ALLOW_SCREENSAVER"
    case videoHighdpiDisabled = "VIDEO_HIGHDPI_DISABLED"
    case videoMacFullscreenSpaces = "VIDEO_MAC_FULLSCREEN_SPACES"
    case videoMinimizeOnFocusLoss = "VIDEO_MINIMIZE_ON_FOCUS_LOSS"
    case videoWindowSharePixelFormat = "VIDEO_WINDOW_SHARE_PIXEL_FORMAT"
    case videoWinD3dcompiler = "VIDEO_WIN_D3DCOMPILER"
    case videoX11NetWmPing = "VIDEO_X11_NET_WM_PING"
    case videoX11Xinerama = "VIDEO_X11_XINERAMA"
    case videoX11Xrandr = "VIDEO_X11_XRANDR"
    case videoX11Xvidmode = "VIDEO_X11_XVIDMODE"
    case windowsEnableMessageloop = "WINDOWS_ENABLE_MESSAGELOOP"
    case windowsNoCloseOnAltF4 = "WINDOWS_NO_CLOSE_ON_ALT_F4"
    case windowFrameUsableWhileCursorHidden = "WINDOW_FRAME_USABLE_WHILE_CURSOR_HIDDEN"
    case winrtHandleBackButton = "WINRT_HANDLE_BACK_BUTTON"
    case winrtPrivacyPolicyLabel = "WINRT_PRIVACY_POLICY_LABEL"
    case winrtPrivacyPolicyUrl = "WINRT_PRIVACY_POLICY_URL"
    case xinputEnabled = "XINPUT_ENABLED"
    case xinputUseOldJoystickMapping = "XINPUT_USE_OLD_JOYSTICK_MAPPING"

    public enum Priority: UInt32 {

      case `default` = 0
      case normal
      case `override`
    }

    // TODO(vdka): How to handle set fail case.
    public static func set(_ hint: Hint, value: String, priority: Priority? = nil) {
      switch priority {
      case let priority?:
        SDL_SetHintWithPriority(hint.rawValue, value, SDL_HintPriority(rawValue: priority.rawValue))

      case nil:
        SDL_SetHint(hint.rawValue, value)
      }
    }

    public static func get(_ hint: Hint) -> String {

      return String(cString: SDL_GetHint(hint.rawValue))
    }

    public static func clearAll() {
      SDL_ClearHints()
    }

    // TODO(vdka): Hint callbacks
  }
}

