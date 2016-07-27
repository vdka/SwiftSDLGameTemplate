
import SDL

extension Rect {

  public init(origin: V2, size: V2) {
    self.x = Int32(origin.x)
    self.y = Int32(origin.y)
    self.w = Int32(size.x)
    self.h = Int32(size.y)
  }
}
