
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

//var window = SDL.createWindow(titled: "SDL Swift Template",
//                              x: Int32.WindowPosition.centered | (startScreen - 2),
//                              y: Int32.WindowPosition.centered | (startScreen - 2),
//                              w: 368, h: 320, flags: [.shown])
//
//var renderer = SDL.createRenderer(forWindow: window)

var (window, renderer) = try SDL.createWindowAndRenderer(w: 200, h: 360, windowFlags: [.shown])

var countedFrames = 0

typealias UpdateFunction = @convention(c) (UnsafeMutablePointer<Void>, UnsafePointer<SDL_Event>?) -> Bool
typealias RenderFunction = @convention(c) (UnsafeMutablePointer<Void>, OpaquePointer?, OpaquePointer?) -> Void

var gameState = UnsafeMutablePointer<Void>(allocatingCapacity: 2048)

while (shouldContinue) {

  try gameEngine.reload()
  try gameRenderer.reload()

  SDL_RenderClear(renderer.pointer)

  var event = SDL_Event()
  SDL_PollEvent(&event)

  if let update = gameEngine.getSymbol("gameUpdate") {
    shouldContinue = unsafeBitCast(update, to: UpdateFunction.self)(gameState, &event)
  }
  if let render = gameRenderer.getSymbol("gameRender") {
    unsafeBitCast(render, to: RenderFunction.self)(gameState, renderer.pointer, window.pointer)
  }

  SDL_UpdateWindowSurface(window.pointer)
  SDL_RenderPresent(renderer.pointer)
  SDL_RenderClear(renderer.pointer)

  // TODO(vkda): Actual frame rate handling
  SDL_Delay(15)
}
