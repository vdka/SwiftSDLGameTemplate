
// TODO(vdka): investigate removal of inout
//  `var value = value` may work but also may invoke a copy, would be nice to know
public func write<T>(_ value: inout T, to destinationPointer: UnsafeMutablePointer<Byte>) {

  let nBytes = sizeofValue(value)
  withUnsafeMutablePointer(&value) {

    let valuePointer = unsafeBitCast($0, to: UnsafeMutablePointer<Byte>.self)
    for byteOffset in 0..<nBytes {
      destinationPointer.advanced(by: byteOffset).pointee = valuePointer.advanced(by: byteOffset).pointee
    }
  }
}

public func write<A, B>(_ a: inout A, _ b: inout B, to desintationPointer: UnsafeMutablePointer<Byte>) {

  var currentOffset = 0

  write(&a, to: desintationPointer.advanced(by: currentOffset))
  currentOffset += sizeofValue(a)

  write(&b, to: desintationPointer.advanced(by: currentOffset))
  currentOffset += sizeofValue(b)
}

public func write<A, B, C>(_ a: inout A, _ b: inout B, _ c: inout C, to desintationPointer: UnsafeMutablePointer<Byte>) {

  var currentOffset = 0

  write(&a, to: desintationPointer.advanced(by: currentOffset))
  currentOffset += sizeofValue(a)

  write(&b, to: desintationPointer.advanced(by: currentOffset))
  currentOffset += sizeofValue(b)

  write(&c, to: desintationPointer.advanced(by: currentOffset))
  currentOffset += sizeofValue(c)
}

public func write<A, B, C, D>(_ a: inout A, _ b: inout B, _ c: inout C, _ d: inout D, to desintationPointer: UnsafeMutablePointer<Byte>) {

  var currentOffset = 0

  write(&a, to: desintationPointer.advanced(by: currentOffset))
  currentOffset += sizeofValue(a)

  write(&b, to: desintationPointer.advanced(by: currentOffset))
  currentOffset += sizeofValue(b)

  write(&c, to: desintationPointer.advanced(by: currentOffset))
  currentOffset += sizeofValue(c)

  write(&d, to: desintationPointer.advanced(by: currentOffset))
  currentOffset += sizeofValue(d)
}

extension UnsafeMutablePointer {

  public func object<T>(at offset: Int) -> T {

    return UnsafePointer<T>(self.advanced(by: offset)).pointee
  }
}
