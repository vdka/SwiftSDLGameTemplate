
let gameEngine = DynamicLib(path: buildDir + "libGameEngine.dylib")
try gameEngine.load()

var initialized = false
var shouldContinue = true

typealias InitializeFunction = @convention(c) (UnsafeMutablePointer<Void>) -> Bool
typealias UpdateFunction = @convention(c) (UnsafeMutablePointer<Void>, UnsafePointer<SDL_Event>?) -> Bool

var memory = UnsafeMutablePointer<Void>(allocatingCapacity: 2048)

guard let initialize = gameEngine.getSymbol("initialize") else { print("Failure to launch! No 'initialize' symbol found!"); exit(1) }

unsafeBitCast(initialize, to: InitializeFunction.self)(memory)

while (shouldContinue) {

  try gameEngine.reload()

  if let loop = gameEngine.getSymbol("loop") {
    shouldContinue = unsafeBitCast(update, to: UpdateFunction.self)(gameState, &event)
  }
}

print("Did quit cleanly!")

