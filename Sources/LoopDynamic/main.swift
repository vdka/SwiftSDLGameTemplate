
let gameEngine = DynamicLib(path: buildDir + "libGameEngine.dylib")
try gameEngine.load()

var shouldQuit = false

typealias Byte = UInt8

// If return nil there was an error during initialization
typealias LoadFunction   = @convention(c) () -> UnsafeMutablePointer<Byte>?
typealias OnLoadFunction = @convention(c) (UnsafeMutablePointer<Byte>?) -> Void
typealias UpdateFunction = @convention(c) (UnsafeMutablePointer<Byte>?) -> Bool

let initialize = gameEngine.unsafeSymbol(named: "load", withSignature: LoadFunction.self)

var memory = initialize?()

guard memory != nil else { fatalError("Call to initialize function failed") }

while (!shouldQuit) {

  if gameEngine.shouldReload {

    try gameEngine.reload()

    let onLoad = gameEngine.unsafeSymbol(named: "onLoad", withSignature: OnLoadFunction.self)

    onLoad?(memory)
  }

  guard let loop = gameEngine.symbol(named: "update") else {
    print("update function missing")
    continue
  }

  shouldQuit = unsafeBitCast(loop, to: UpdateFunction.self)(memory)
}

print("Did quit cleanly!")
