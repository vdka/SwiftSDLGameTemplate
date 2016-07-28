//
//  VectorMath.swift
//  VectorMath
//
//  Version 0.2
//
//  Created by Nick Lockwood on 24/11/2014.
//  Copyright (c) 2014 Nick Lockwood. All rights reserved.
//
//  Distributed under the permissive zlib License
//  Get the latest version from here:
//
//  https://github.com/nicklockwood/VectorMath
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//

import Darwin.C

// MARK: Types

public typealias Scalar = Double

extension Scalar {
  static let pi = Scalar(M_PI)
  static let halfPi = Scalar(M_PI_2)
  static let quarterPi = Scalar(M_PI_4)
  static let twoPi = Scalar(M_PI * 2)
  static let degreesPerRadian = 180 / pi
  static let radiansPerDegree = pi / 180
  static let epsilon: Scalar = 0.0001
}

// TODO(vdka): Swift value type things. Such as Equatable.

public typealias V2 = Vector2
public struct Vector2 {
  public var x: Scalar
  public var y: Scalar

  public init(x: Scalar, y: Scalar) {
    self.x = x
    self.y = y
  }
}

extension Vector2 {

  public static let up     = V2(x:  0, y:  1)
  public static let down   = V2(x:  0, y: -1)
  public static let left   = V2(x: -1, y:  0)
  public static let right  = V2(x:  1, y:  0)
}

public typealias V3 = Vector3
public struct Vector3 {
  public var x: Scalar
  public var y: Scalar
  public var z: Scalar

  public init(x: Scalar, y: Scalar, z: Scalar) {
    self.x = x
    self.y = y
    self.z = z
  }
}

public typealias V4 = Vector4
public struct Vector4 {
  public var x: Scalar
  public var y: Scalar
  public var z: Scalar
  public var w: Scalar

  public init(x: Scalar, y: Scalar, z: Scalar, w: Scalar) {
    self.x = x
    self.y = y
    self.z = z
    self.w = w
  }
}

// MARK: Scalar

public func ~= (lhs: Scalar, rhs: Scalar) -> Bool {
  return abs(lhs - rhs) < .epsilon
}

// MARK: Vector2

extension Vector2: Equatable, Hashable {
  public static let zero = Vector2(0, 0)

  public var hashValue: Int {
    return x.hashValue &+ y.hashValue
  }

  public var lengthSquared: Scalar {
    return x * x + y * y
  }

  public var length: Scalar {
    return sqrt(lengthSquared)
  }

  public var inverse: Vector2 {
    return -self
  }

  public init(_ x: Scalar, _ y: Scalar) {
    self.init(x: x, y: y)
  }

  public init(_ v: [Scalar]) {
    assert(v.count == 2, "array must contain 2 elements, contained \(v.count)")

    x = v[0]
    y = v[1]
  }

  public func toArray() -> [Scalar] {
    return [x, y]
  }

  public func dot(_ v: Vector2) -> Scalar {
    return x * v.x + y * v.y
  }

  public func cross(_ v: Vector2) -> Scalar {
    return x * v.y - y * v.x
  }

  public func normalized() -> Vector2 {
    let lengthSquared = self.lengthSquared
    if lengthSquared ~= 0 || lengthSquared ~= 1 {
      return self
    }
    return self / sqrt(lengthSquared)
  }

  public func rotated(by radians: Scalar) -> Vector2 {
    let cs = cos(radians)
    let sn = sin(radians)
    return Vector2(x * cs - y * sn, x * sn + y * cs)
  }

  public func rotated(by radians: Scalar, around pivot: Vector2) -> Vector2 {
    return (self - pivot).rotated(by: radians) + pivot
  }

  public func angle(with v: Vector2) -> Scalar {
    if self == v {
      return 0
    }

    let t1 = normalized()
    let t2 = v.normalized()
    let cross = t1.cross(t2)
    let dot = max(-1, min(1, t1.dot(t2)))

    return atan2(cross, dot)
  }

  public func interpolated(with v: Vector2, t: Scalar) -> Vector2 {
    return self + (v - self) * t
  }
}

public prefix func - (v: Vector2) -> Vector2 {
  return Vector2(-v.x, -v.y)
}

public func + (lhs: Vector2, rhs: Vector2) -> Vector2 {
  return Vector2(lhs.x + rhs.x, lhs.y + rhs.y)
}

public func - (lhs: Vector2, rhs: Vector2) -> Vector2 {
  return Vector2(lhs.x - rhs.x, lhs.y - rhs.y)
}

public func * (lhs: Vector2, rhs: Vector2) -> Vector2 {
  return Vector2(lhs.x * rhs.x, lhs.y * rhs.y)
}

public func * (lhs: Vector2, rhs: Scalar) -> Vector2 {
  return Vector2(lhs.x * rhs, lhs.y * rhs)
}

public func / (lhs: Vector2, rhs: Vector2) -> Vector2 {
  return Vector2(lhs.x / rhs.x, lhs.y / rhs.y)
}

public func / (lhs: Vector2, rhs: Scalar) -> Vector2 {
  return Vector2(lhs.x / rhs, lhs.y / rhs)
}

public func += (left: inout Vector2, right: Vector2) {
  left = left + right
}

public func -= (left: inout Vector2, right: Vector2) {
  left = left - right
}

public func *= (left: inout Vector2, right: Vector2) {
  left = left * right
}

public func *= (left: inout Vector2, right: Scalar) {
  left = left * right
}

public func /= (left: inout Vector2, right: Vector2) {
  left = left / right
}

public func /= (left: inout Vector2, right: Scalar) {
  left = left / right
}

public func == (lhs: Vector2, rhs: Vector2) -> Bool {
  return lhs.x == rhs.x && lhs.y == rhs.y
}

public func ~= (lhs: Vector2, rhs: Vector2) -> Bool {
  return lhs.x ~= rhs.x && lhs.y ~= rhs.y
}

extension Scalar {

  // Round the given value to a specified number
  // of decimal places
  func round(to decimalPlaces: Int) -> Double {
    let divisor = pow(10.0, Double(decimalPlaces))
    return Darwin.round(self * divisor) / divisor
  }
}

extension Vector2: CustomStringConvertible {

  public var description: String {
    return "(x: \(x.round(to: 2)), y: \(y.round(to: 2)))"
  }
}

// MARK: Vector3

extension Vector3: Equatable, Hashable {
  public static let zero = Vector3(0, 0, 0)

  public var hashValue: Int {
    return x.hashValue &+ y.hashValue &+ z.hashValue
  }

  public var lengthSquared: Scalar {
    return x * x + y * y + z * z
  }

  public var length: Scalar {
    return sqrt(lengthSquared)
  }

  public var inverse: Vector3 {
    return -self
  }

  public init(_ x: Scalar, _ y: Scalar, _ z: Scalar) {
    self.init(x: x, y: y, z: z)
  }

  public init(_ v: [Scalar]) {
    assert(v.count == 3, "array must contain 3 elements, contained \(v.count)")

    x = v[0]
    y = v[1]
    z = v[2]
  }

  public func toArray() -> [Scalar] {
    return [x, y, z]
  }

  public func dot(_ v: Vector3) -> Scalar {
    return x * v.x + y * v.y + z * v.z
  }

  public func cross(_ v: Vector3) -> Vector3 {
    return Vector3(y * v.z - z * v.y, z * v.x - x * v.z, x * v.y - y * v.x)
  }

  public func normalized() -> Vector3 {
    let lengthSquared = self.lengthSquared
    if lengthSquared ~= 0 || lengthSquared ~= 1 {
      return self
    }
    return self / sqrt(lengthSquared)
  }

  public func interpolated(with v: Vector3, t: Scalar) -> Vector3 {
    return self + (v - self) * t
  }
}

public prefix func - (v: Vector3) -> Vector3 {
  return Vector3(-v.x, -v.y, -v.z)
}

public func + (lhs: Vector3, rhs: Vector3) -> Vector3 {
  return Vector3(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z)
}

public func - (lhs: Vector3, rhs: Vector3) -> Vector3 {
  return Vector3(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z)
}

public func * (lhs: Vector3, rhs: Vector3) -> Vector3 {
  return Vector3(lhs.x * rhs.x, lhs.y * rhs.y, lhs.z * rhs.z)
}

public func * (lhs: Vector3, rhs: Scalar) -> Vector3 {
  return Vector3(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs)
}

public func / (lhs: Vector3, rhs: Vector3) -> Vector3 {
  return Vector3(lhs.x / rhs.x, lhs.y / rhs.y, lhs.z / rhs.z)
}

public func / (lhs: Vector3, rhs: Scalar) -> Vector3 {
  return Vector3(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs)
}

public func += (left: inout Vector3, right: Vector3) {
  left = left + right
}

public func -= (left: inout Vector3, right: Vector3) {
  left = left - right
}

public func *= (left: inout Vector3, right: Vector3) {
  left = left * right
}

public func *= (left: inout Vector3, right: Scalar) {
  left = left * right
}

public func /= (left: inout Vector3, right: Vector3) {
  left = left / right
}

public func /= (left: inout Vector3, right: Scalar) {
  left = left / right
}

public func == (lhs: Vector3, rhs: Vector3) -> Bool {
  return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
}

public func ~= (lhs: Vector3, rhs: Vector3) -> Bool {
  return lhs.x ~= rhs.x && lhs.y ~= rhs.y && lhs.z ~= rhs.z
}

extension Vector3: CustomStringConvertible {

  public var description: String {
    return "(x: \(x.round(to: 2)), y: \(y.round(to: 2)), z: \(z.round(to: 2)))"
  }
}

// MARK: Vector4

extension Vector4: Equatable, Hashable {
  public static let zero = Vector4(0, 0, 0, 0)

  public var hashValue: Int {
    return x.hashValue &+ y.hashValue &+ z.hashValue &+ w.hashValue
  }

  public var lengthSquared: Scalar {
    return x * x + y * y + z * z + w * w
  }

  public var length: Scalar {
    return sqrt(lengthSquared)
  }

  public var inverse: Vector4 {
    return -self
  }

  public init(_ x: Scalar, _ y: Scalar, _ z: Scalar, _ w: Scalar) {
    self.init(x: x, y: y, z: z, w: w)
  }

  public init(_ v: [Scalar]) {
    assert(v.count == 4, "array must contain 4 elements, contained \(v.count)")

    x = v[0]
    y = v[1]
    z = v[2]
    w = v[3]
  }

  public func toArray() -> [Scalar] {
    return [x, y, z, w]
  }

  public func dot(_ v: Vector4) -> Scalar {
    return x * v.x + y * v.y + z * v.z + w * v.w
  }

  public func normalized() -> Vector4 {
    let lengthSquared = self.lengthSquared
    if lengthSquared ~= 0 || lengthSquared ~= 1 {
      return self
    }
    return self / sqrt(lengthSquared)
  }

  public func interpolated(with v: Vector4, t: Scalar) -> Vector4 {
    return self + (v - self) * t
  }
}

public prefix func - (v: Vector4) -> Vector4 {
  return Vector4(-v.x, -v.y, -v.z, -v.w)
}

public func + (lhs: Vector4, rhs: Vector4) -> Vector4 {
  return Vector4(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z, lhs.w + rhs.w)
}

public func - (lhs: Vector4, rhs: Vector4) -> Vector4 {
  return Vector4(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z, lhs.w - rhs.w)
}

public func * (lhs: Vector4, rhs: Vector4) -> Vector4 {
  return Vector4(lhs.x * rhs.x, lhs.y * rhs.y, lhs.z * rhs.z, lhs.w * rhs.w)
}

public func * (lhs: Vector4, rhs: Scalar) -> Vector4 {
  return Vector4(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs, lhs.w * rhs)
}

public func / (lhs: Vector4, rhs: Vector4) -> Vector4 {
  return Vector4(lhs.x / rhs.x, lhs.y / rhs.y, lhs.z / rhs.z, lhs.w / rhs.w)
}

public func / (lhs: Vector4, rhs: Scalar) -> Vector4 {
  return Vector4(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs, lhs.w / rhs)
}

public func += (left: inout Vector4, right: Vector4) {
  left = left + right
}

public func -= (left: inout Vector4, right: Vector4) {
  left = left - right
}

public func *= (left: inout Vector4, right: Vector4) {
  left = left * right
}

public func *= (left: inout Vector4, right: Scalar) {
  left = left * right
}

public func /= (left: inout Vector4, right: Vector4) {
  left = left / right
}

public func /= (left: inout Vector4, right: Scalar) {
  left = left / right
}

public func == (lhs: Vector4, rhs: Vector4) -> Bool {
  return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z && lhs.w == rhs.w
}

public func ~= (lhs: Vector4, rhs: Vector4) -> Bool {
  return lhs.x ~= rhs.x && lhs.y ~= rhs.y && lhs.z ~= rhs.z && lhs.w ~= rhs.w
}

extension Vector4: CustomStringConvertible {

  public var description: String {
    return "(x: \(x.round(to: 2)), y: \(y.round(to: 2)), z: \(z.round(to: 2)), w: \(w.round(to: 2)))"
  }
}
