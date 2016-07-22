
let gameEngine = DynamicLib(path: buildDir + "libGameEngine.dylib")
try gameEngine.load()

var shouldContinue = true

typealias Byte = UInt8

// If return nil there was an error during initialization
typealias InitFunction = @convention(c) () -> UnsafeMutablePointer<Byte>?
typealias LoopFunction = @convention(c) (UnsafeMutablePointer<Byte>?) -> Bool

guard let initialize = gameEngine.getSymbol("initialize") else { fatalError("Failure to launch! No 'initialize' symbol found!") }

var memory = unsafeBitCast(initialize, to: InitFunction.self)()

guard memory != nil else { fatalError("Call to initialize function failed") }

while (shouldContinue) {

  try gameEngine.reload()

  guard let loop = gameEngine.getSymbol("update") else { print("loop function missing"); continue }

  shouldContinue = unsafeBitCast(loop, to: LoopFunction.self)(memory)
}

print("Did quit cleanly!")

