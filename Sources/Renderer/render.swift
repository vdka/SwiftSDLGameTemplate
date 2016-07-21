
import CSDL2
import SwiftPCG
import Shared

@_silgen_name("gameRender")
func render(gameState: UnsafeMutablePointer<Void>, renderer: OpaquePointer!, window: OpaquePointer!) {

  var rect = SDL_Rect(x: 0, y: 0, w: 1, h: 1)

  SDL_SetRenderDrawColor(renderer, 0x00, 0xcc, 0xff, 0xff)
  SDL_RenderDrawRect(renderer, &rect)
}
