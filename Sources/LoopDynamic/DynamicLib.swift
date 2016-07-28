
import Darwin.C

func curTime() -> Double {

  var tv = timeval()
  gettimeofday(&tv, nil)

  return Double(tv.tv_sec) + Double(tv.tv_usec) / 1000000
}

public final class DynamicLib {

  public var path: String
  private var handle: UnsafeMutablePointer<Void>?
  public var lastReadTime: Int?

  public var lastWriteTime: Int? {

    var fileStats = stat()
    guard stat(path, &fileStats) == 0 else { return nil }
    return fileStats.st_mtimespec.tv_sec
  }

  public init(path: String) {

    self.path = path
  }

  deinit {
    do {
      try unload()
    } catch {
      print("Error \(error) while unloading library at \(path)")
    }
  }

  public func load() throws {

    guard dlopen_preflight(path) else {
      if DynamicLib.lastError.hasSuffix("image not found") {
        throw Error(.libNotFound)
      }
      throw Error(.incompatibleBinary) }
    handle = dlopen(path, RTLD_LAZY)

    guard handle != nil else { throw Error(.failedToLoadLibrary) }

    lastReadTime = lastWriteTime
  }

  public func unload() throws {
    guard let handle = handle else { throw Error(.libraryNotOpen) }
    guard dlclose(handle) == 0 else { throw Error(.unknown) }

    self.handle = nil
  }

  public var shouldReload: Bool {
    return lastWriteTime != lastReadTime
  }

  public func reload() throws {

    let startTime = curTime()

    // only reload if the last write did not occur when the last read did.
    guard shouldReload else { return }

    print("Reloading \(path.characters.split(separator: "/").last.flatMap(String.init)!)")

    try unload()
    while lastWriteTime == nil && curTime() - startTime < 1 {
      usleep(1)
    }
    try load()

    print("Reload successful!")
  }

  public func unsafeSymbol<T>(named name: String, withSignature: T.Type) -> T? {

    guard let symbol = symbol(named: name) else { return nil }

    return unsafeBitCast(symbol, to: T.self)
  }

  public func symbol(named name: String) -> UnsafeMutablePointer<()>? {
    guard handle != nil else { return nil }

    let symbol = dlsym(handle, name)

    return symbol
  }

  private static var lastError: String {
    return String(cString: dlerror())
  }
}

extension DynamicLib {

  struct Error: Swift.ErrorProtocol {

    init(_ reason: Reason) {
      self.reason = reason
      self.dlError = DynamicLib.lastError
    }

    var reason: Reason
    var dlError: String
    enum Reason {
      case incompatibleBinary
      case libNotFound
      case failedToLoadLibrary
      case failedToUnLoadLibrary
      case symbolNotFound
      case libraryNotOpen
      case unknown
    }
  }
}
