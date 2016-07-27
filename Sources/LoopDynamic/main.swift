
let gameEngine = DynamicLib(path: buildDir + "libGameEngine.dylib")
try gameEngine.load()

var shouldQuit = false

typealias Byte = UInt8

// If return nil there was an error during initialization
typealias LoadFunction   = @convention(c) () -> UnsafeMutablePointer<Byte>?
typealias OnLoadFunction = @convention(c) () -> Void
typealias LoopFunction   = @convention(c) (UnsafeMutablePointer<Byte>?) -> Bool

guard let initialize = gameEngine.getSymbol("load") else { fatalError("Failure to launch! No 'initialize' symbol found!") }

var memory = unsafeBitCast(initialize, to: LoadFunction.self)()

guard memory != nil else { fatalError("Call to initialize function failed") }

while (!shouldQuit) {

  try gameEngine.reload()
  if let onLoad = gameEngine.getSymbol("onLoad") {
    unsafeBitCast(onLoad, to: OnLoadFunction.self)()
  }

  guard let loop = gameEngine.getSymbol("update") else { print("loop function missing"); continue }

  shouldQuit = unsafeBitCast(loop, to: LoopFunction.self)(memory)
}

print("Did quit cleanly!")
