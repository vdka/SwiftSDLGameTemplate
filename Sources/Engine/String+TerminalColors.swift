
extension String {

  public func colored(rgb: UInt32) -> String {

    let r = UInt8((rgb & 0xff0000) >> 16)
    let g = UInt8((rgb & 0x00ff00) >>  8)
    let b = UInt8((rgb & 0x0000ff) >>  0)

    return "\u{001B}[38;2;\(r);\(g);\(b)m\(self)\u{001B}[0m"
  }
}
