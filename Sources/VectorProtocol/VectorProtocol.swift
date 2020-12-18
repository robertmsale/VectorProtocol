// VectorProtocol.swift
// Created by Robert Sale on 8/27/20

import Foundation
import Accelerate
import SceneKit

public protocol VectorAxis: CaseIterable, Hashable {}
public enum V2Axis: VectorAxis { case x, y }
public enum V3Axis: VectorAxis { case x, y, z }
public enum V4Axis: VectorAxis { case x, y, z, w }

/// Protocol which adds common functionality to any conforming Vector types
public protocol Vector: Equatable {
    /// The underlying Floating Point data type
    associatedtype BFP: BinaryFloatingPoint
    /// Enumeration used in subscript
    associatedtype Axis: VectorAxis
    /// Input an axis and receive the underlying value
    subscript(axis: Axis) -> BFP { get set }
}
public extension Vector {
    
    /// Add scale to every axis
    mutating func addScalar(scale s: BFP) { for a in Axis.allCases { self[a] += s } }
    /// Add scale to every axis
    mutating func addScalar(_ s: BFP) { addScalar(scale: s) }
    /// Add scale to every axis and return new vector
    func addedScalar(scale s: BFP) -> Self { var v = self; v.addScalar(s); return v }
    /// Add scale to every axis and return new vector
    func addedScalar(_ s: BFP) -> Self { addedScalar(scale: s) }
    /// Add some vector to this vector
    mutating func add(_ v: Self) { for a in Axis.allCases { self[a] += v[a] }}
    /// Add some vector to this vector and return new vector
    func added(_ v: Self) -> Self { var x = self; x.add(v); return x }
    
    /// Subtract scalar from every axis
    mutating func subScalar(scale s: BFP) { for a in Axis.allCases { self[a] -= s } }
    /// Subtract scalar from every axis
    mutating func subScalar(_ s: BFP) { subScalar(scale: s) }
    /// Subtract scalar from every axis and return new vector
    func subbedScalar(scale s: BFP) -> Self { var v = self; v.subScalar(s); return v }
    /// Subtract scalar from every axis and return new vector
    func subbedScalar(_ s: BFP) -> Self { subbedScalar(scale: s) }
    /// Subtract some vector from this vector
    mutating func sub(_ v: Self) { for a in Axis.allCases { self[a] -= v[a] }}
    /// Subtract some vector from this vector and return new vector
    func subbed(_ v: Self) -> Self { var x = self; x.sub(v); return x }
    
    /// Multiply scalar from every axis
    mutating func multiplyScalar(scale s: BFP) { for a in Axis.allCases { self[a] *= s } }
    /// Multiply scalar from every axis
    mutating func multiplyScalar(_ s: BFP) { multiplyScalar(scale: s) }
    /// Multiply scalar from every axis and return new vector
    func multipliedScalar(scale s: BFP) -> Self { var v = self; v.multiplyScalar(s); return v }
    /// Multiply scalar from every axis and return new vector
    func multipliedScalar(_ s: BFP) -> Self { multipliedScalar(scale: s) }
    /// Multiply this vector by some vector
    mutating func multiply(_ v: Self) { for a in Axis.allCases { self[a] *= v[a] }}
    /// Multiply this vector by some vector and return new vector
    func multiplied(_ v: Self) -> Self { var x = self; x.multiply(v); return x }
    
    /// Divide scalar from every axis
    mutating func divideScalar(scale s: BFP) { for a in Axis.allCases { self[a] /= s } }
    /// Divide scalar from every axis
    mutating func divideScalar(_ s: BFP) { divideScalar(scale: s) }
    /// Divide scalar from every axis and return new vector
    func dividedScalar(scale s: BFP) -> Self { var v = self; v.divideScalar(s); return v }
    /// Divide scalar from every axis and return new vector
    func dividedScalar(_ s: BFP) -> Self { dividedScalar(scale: s) }
    /// Divide this vector by some vector
    mutating func divide(_ v: Self) { for a in Axis.allCases { self[a] /= v[a] }}
    /// Divide this vector by some vector and return new vector
    func divided(_ v: Self) -> Self { var x = self; x.add(v); return x }
    
    /// Take a dictionary, where the keys are *Axis* and the values are *BFP*, and translate this Vector's axes by those values
    mutating func translate(coordinates c: [Axis: BFP]) { for (k, v) in c { self[k] += v } }
    /// Take a dictionary, where the keys are *Axis* and the values are *BFP*, and translate this Vector's axes by those values
    mutating func translate(_ c: [Axis: BFP]) { translate(coordinates: c) }
    /// Translate this vector by the values of another vector
    mutating func translate(_ v: Self) { for a in Axis.allCases { self[a] += v[a] } }
    /// Take a dictionary, where the keys are *Axis* and the values are *BFP*, translate this Vector's axes by those values, and return new vector
    func translated(coordinates c: [Axis: BFP]) -> Self { var v = self; v.translate(coordinates: c); return v }
    /// Take a dictionary, where the keys are *Axis* and the values are *BFP*, and translate this Vector's axes by those values
    func translated(_ c: [Axis: BFP]) -> Self { translated(coordinates: c) }
    /// Translate this vector by the values of another vector and return new vector
    func translated(_ v: Self) -> Self { var new = self; new.translate(v); return new }
    
    /// Variadic function for flipping, or inverting, each axis
    mutating func flip(_ axis: Axis...) {
        for a in axis { self[a] = -self[a] }
    }
    /// Variadic function for flipping, or inverting, each axis, then returning new vector
    func flipped(_ axis: Axis...) -> Self {
        var v = self
        for a in axis { v[a] = -v[a] }
        return v
    }
    
    /// Zero out selected axes
    mutating func zero(_ axis: Axis...) {
        for a in axis { self[a] = 0 }
    }
    /// Zero out selected axes and return new vector
    func zeroed(_ axis: Axis...) -> Self {
        var v = self
        for a in axis { v.zero(a) }
        return v
    }
    
    /// Floor the value of each axis
    mutating func floor() {
        for a in Axis.allCases { self[a] = self[a].floor }
    }
    /// Floor the value of each axis and return new vector
    func floored() -> Self {
        var v = self
        v.floor()
        return v
    }
    
    /// Ceil the value of each axis
    mutating func ceil() {
        for a in Axis.allCases { self[a] = self[a].ceil }
    }
    /// Ceil the value of each axis and return new vector
    func ceiled() -> Self {
        var v = self
        v.ceil()
        return v
    }
    
    /// Round each axis using schoolbook rounding (to nearest whole number)
    mutating func round() { for a in Axis.allCases { self[a].round() } }
    /// Round each axis using schoolbook rounding (to nearest whole number) and return result
    func rounded() -> Self { var v = self; v.round(); return v }
    /// Round each axis to the nearest *BFP*
    mutating func round(to: BFP) { for a in Axis.allCases { self[a].round(toNearest: to) } }
    /// Round each axis to the nearest *BFP* and return result
    func rounded(to: BFP) -> Self { var v = self; v.round(to: to); return v }
    /// Round each axis towards zero
    mutating func roundToZero() { for a in Axis.allCases { if self[a] < 0 { self[a] = self[a].ceil } else { self[a] = self[a].floor } } }
    /// Round each axis towards zero and return result
    func roundedToZero() -> Self { var v = self; v.roundToZero(); return v }
    
    /// Get the distance between two vectors
    func distanceSquared(_ to: Self) -> BFP {
        let vals = Axis.allCases.map({a -> BFP in let x=self[a].distance(to[a]); return x * x})
        return vals.reduce(into: 0, {(res, next) in res += next})
    }
    /// Get the distance between two vectors ( precise )
    func distance(_ to: Self) -> BFP { sqrt(distanceSquared(to)) }
    /// Get the distance between two vectors at each whole step, one direction at a time (like traversing city blocks)
    func manhattanDistance(_ to: Self) -> BFP {
        let vals = Axis.allCases.map({a in abs(self[a] - to[a])})
        return vals.reduce(into: 0, {(res, next) in res += next})
    }
    
    /// Get the length
    var lengthSquared: BFP {
        return Axis.allCases.map({c in self[c] * self[c]}).reduce(into: 0, {(res, next) in res += next})
    }
    /// Get the length ( precise )
    var length: BFP { sqrt(lengthSquared) }
    /// Get the length from Zero at each whole step, one direction at a time
    var manhattanLength: BFP {
        return Axis.allCases.map({c in abs(self[c])}).reduce(into: 0, {(res, next) in res += next})
    }
    
    /// Get the dot product of two vectors
    func dotProduct(_ v: Self) -> BFP {
        return Axis.allCases.map({c in self[c] * v[c]}).reduce(into: 0, {(res, next) in res += next})
    }
    /// Get the cross product of two vectors
    func crossProduct(_ v: Self) -> BFP {
        let vals = Axis.allCases.map({c in self[c] * v[c]})
        return vals.dropFirst().reduce(into: vals[0], {(res, next) in res -= next})
    }
    
    /// Normalize the vector
    mutating func normalize() { divideScalar(length == 0 ? BFP(1) : BFP(length)) }
    /// Normalize and return new vector
    func normalized() -> Self { var v = self; v.normalize(); return v }
    
    static func + (l: Self, r: Self) -> Self { var v = l; for a in Axis.allCases { v[a] = l[a] + r[a] }; return v }
    static func - (l: Self, r: Self) -> Self { var v = l; for a in Axis.allCases { v[a] = l[a] - r[a] }; return v }
    static func * (l: Self, r: Self) -> Self { var v = l; for a in Axis.allCases { v[a] = l[a] * r[a] }; return v }
    static func / (l: Self, r: Self) -> Self { var v = l; for a in Axis.allCases { v[a] = l[a] / (r[a] == 0 ? 1 : r[a]) }; return v }
    
    static func += (l: inout Self, r: Self) { l = l + r }
    static func -= (l: inout Self, r: Self) { l = l - r }
    static func *= (l: inout Self, r: Self) { l = l * r }
    static func /= (l: inout Self, r: Self) { l = l / r }
    
    static func + (l: Self, r: BFP) -> Self { l.addedScalar(r) }
    static func - (l: Self, r: BFP) -> Self { l.subbedScalar(r) }
    static func * (l: Self, r: BFP) -> Self { l.multipliedScalar(r) }
    static func / (l: Self, r: BFP) -> Self { l.dividedScalar(r == 0 ? 1 : r) }
    
    static func += (l: inout Self, r: BFP) { l.addScalar(r) }
    static func -= (l: inout Self, r: BFP) { l.subScalar(r) }
    static func *= (l: inout Self, r: BFP) { l.multiplyScalar(r) }
    static func /= (l: inout Self, r: BFP) { l.divideScalar(r == 0 ? 1 : r) }
    
    static prefix func - (v: Self) -> Self { var new = v; for a in Axis.allCases { new.flip(a) }; return new }
}

