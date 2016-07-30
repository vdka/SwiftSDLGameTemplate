
import CSDL2

/// Sidestep the naming conventions for clarity. `log` is now a sinple namespace
enum log {

  static func info<T>(_ input: T,
                   file: StaticString = #file, line: UInt = #line, function: StaticString = #function) {

    let str = String(reflecting: input)

    let file = String(String(file).characters.split(separator: "/").last!)

    print("[\(SDL_GetTicks()) | \(file):\(line)] \("INFO".colored(rgb: 0x00ccff)): \(str)")
  }

  static func warning<T>(_ input: T,
                   file: StaticString = #file, line: UInt = #line, function: StaticString = #function) {

    let str = String(reflecting: input)

    let file = String(String(file).characters.split(separator: "/").last!)

    print("[\(SDL_GetTicks()) | \(file):\(line)] \("WARNING".colored(rgb: 0xff8d00)): \(str)")
  }

  static func error<T>(_ input: T,
                   file: StaticString = #file, line: UInt = #line, function: StaticString = #function) {

    let str = String(reflecting: input)

    let file = String(String(file).characters.split(separator: "/").last!)

    print("[\(SDL_GetTicks()) | \(file):\(line)] \("ERROR".colored(rgb: 0xff0008)): \(str)")
  }
}
