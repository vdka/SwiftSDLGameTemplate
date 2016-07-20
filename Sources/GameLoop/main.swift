
import CSDL2
import SDL

var shouldContinue = true

let gameEngine = DynamicLib(path: buildDir + "libGameEngine.dylib")

let gameRenderer = DynamicLib(path: buildDir + "libGameRenderer.dylib")

try gameEngine.load()
try gameRenderer.load()

try SDL.initialize(components: [.video])
defer { SDL.quit() }

let startScreen = SDL_GetNumVideoDisplays()

var window = SDL_CreateWindow(
  "SDL In Swift",
  SDL_WINDOWPOS_UNDEFINED_MASK | startScreen - 1, SDL_WINDOWPOS_UNDEFINED_MASK | startScreen - 1,
  640, 480, SDL_WINDOW_SHOWN.rawValue)
var renderer = SDL_CreateRenderer(window, 0, SDL_RENDERER_ACCELERATED.rawValue)

var countedFrames = 0

typealias UpdateFunction = @convention(c) (UnsafeMutablePointer<Void>, UnsafePointer<SDL_Event>?) -> Bool
typealias RenderFunction = @convention(c) (UnsafeMutablePointer<Void>, OpaquePointer?, OpaquePointer?) -> Void

var gameState = UnsafeMutablePointer<Void>(allocatingCapacity: 2048)

while (shouldContinue) {

  try gameEngine.reload()
  try gameRenderer.reload()

  SDL_RenderClear(renderer)

  var event = SDL_Event()
  SDL_PollEvent(&event)

  if let update = gameEngine.getSymbol("gameUpdate") {
    shouldContinue = unsafeBitCast(update, to: UpdateFunction.self)(gameState, &event)
  }
  if let render = gameRenderer.getSymbol("gameRender") {
    unsafeBitCast(render, to: RenderFunction.self)(gameState, renderer, window)
  }

  SDL_UpdateWindowSurface(window)
  SDL_RenderPresent(renderer)
  SDL_RenderClear(renderer)

  // TODO(vkda): Actual frame rate handling
  SDL_Delay(15)
}
