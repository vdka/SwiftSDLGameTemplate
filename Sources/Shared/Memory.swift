
// TODO(vdka): investigate removal of inout
//  `var value = value` may work but also may invoke a copy, would be nice to know
public func write<T>(_ value: inout T, to destinationPointer: UnsafeMutablePointer<Byte>) {

  let nBytes = sizeofValue(value)
  withUnsafePointer(&value) {

    let valuePointer = unsafeBitCast($0, to: UnsafePointer<Byte>.self)
    for byteOffset in 0..<nBytes {
      destinationPointer.advanced(by: byteOffset).pointee = valuePointer.advanced(by: byteOffset).pointee
    }
  }
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

extension UnsafeMutablePointer {

  public func object<T>(at offset: Int) -> T {

    return UnsafePointer<T>(self.advanced(by: offset)).pointee
  }

  // TODO(vdka): no modification occurs, therefore would be nice to drop inout.
  public func object<T, U>(following other: inout U) -> T {

    let sizeOfOther = sizeofValue(other)
    return withUnsafeMutablePointer(&other) {
      UnsafePointer<T>($0.advanced(by: sizeOfOther)).pointee
    }
  }
}

