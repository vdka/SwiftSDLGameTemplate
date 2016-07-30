
import func Darwin.round
import SDL

extension Rect {

  init(origin: V2, size: V2) {

    self.x = Int32(round(origin.x))
    self.y = Int32(round(origin.y))
    self.w = Int32(round(size.x))
    self.h = Int32(round(size.y))
  }

  init(center: V2, size: V2) {

    self.x = Int32(round(center.x) - round(size.x / 2))
    self.y = Int32(round(center.y) - round(size.y / 2))
    self.w = Int32(round(size.x))
    self.h = Int32(round(size.y))
  }

  var origin: V2 {
    return V2(Double(x), Double(y))
  }

  var center: V2 {
    return V2(Double(x - w) / 2, Double(y - h) / 2)
  }

  var size: V2 {
    return V2(Double(w), Double(h))
  }

}
