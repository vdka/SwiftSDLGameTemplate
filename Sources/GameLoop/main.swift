
let gameEngine = DynamicLib(path: buildDir + "libGameEngine.dylib")
try gameEngine.load()

var shouldContinue = true

// If return nil there was an error during initialization
typealias InitFunction = @convention(c) () -> UnsafeMutablePointer<Void>?
typealias LoopFunction = @convention(c) (UnsafeMutablePointer<Void>?) -> Bool

guard let initialize = gameEngine.getSymbol("initialize") else { fatalError("Failure to launch! No 'initialize' symbol found!") }

var memory = unsafeBitCast(initialize, to: InitFunction.self)()

guard memory != nil else { fatalError("Call to initialize function failed") }

while (shouldContinue) {

  try gameEngine.reload()

  guard let loop = gameEngine.getSymbol("loop") else { print("loop function missing"); continue }

  shouldContinue = unsafeBitCast(loop, to: LoopFunction.self)(memory)
}

print("Did quit cleanly!")

