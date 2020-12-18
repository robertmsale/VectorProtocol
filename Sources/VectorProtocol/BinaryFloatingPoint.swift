import Foundation
#if canImport(CoreGraphics)
import CoreGraphics
#endif

internal extension BinaryFloatingPoint {
    #if canImport(CoreGraphics)
    /// Shorthand conversion of some Floating Point to or from CGFloat
    var cg: CGFloat { get { CGFloat(self) } set(v) { self = Self(v) } }
    #endif
    /// Shorthand conversion to or from Float
    var f: Float { get { Float(self) } set(v) { self = Self(v) } }
    /// Shorthand conversion to or from Double
    var d: Double { get { Double(self) } set(v) { self = Self(v) } }
    /// Shorthand conversion to or from Int
    var int: Int { get { Int(self) } set(v) { self = Self(v) } }
    
    /**
     Round self to the nearest value of **T**
     #Uses
     Say you need to round to a fractional value (i.e. 1/4th). You would accomplish this task by going:
     ```
     let someValue = 1.333333333
     someValue.round(toNearest: 0.25)
     print(someValue) // 1.25
     ```
     */
    mutating func round<T: BinaryFloatingPoint>(toNearest toN: T) {
        let from = T(self)
        let remainder = from.truncatingRemainder(dividingBy: toN)
        if remainder < toN / 2 { self = Self(from - remainder) }
        else { self = Self(from + (toN - remainder)) }
    }
    /**
     Round self to the nearest value of **T** and return result
     #Uses
     Functionally identical to Self.round, except that it returns the result without mutation
     ```
     let someValue = 1.333333333
     print(someValue.rounded(toNearest: 0.25)) // 1.25
     ```
     */
    func rounded<T: BinaryFloatingPoint>(toNearest toN: T) -> Self {
        let from = T(self)
        let remainder = from.truncatingRemainder(dividingBy: toN)
        var i = toN
        while i < remainder {
            i *= 2
        }
        if remainder < toN / 2 { return Self(from - remainder) }
        return Self(from + (toN - remainder))
    }
    
    /// Convert self to Radians from Degrees
    mutating func toRad() { self *= (Self.pi / 180) }
    /// Convert self to Radians from Degrees and return result
    var rad: Self { self * (Self.pi / 180) }
    /// Convert self to Degrees from Radians
    mutating func toDeg() { self *= (180 / Self.pi) }
    /// Convert self to Degrees from Radians and return result
    var deg: Self { self * (180 / Self.pi) }
    
    /// This number rounded down to nearest whole number
    var floor: Self { self - self.truncatingRemainder(dividingBy: 1.0) }
    /// This number rounded up to nearest whole number
    var ceil: Self { self + ( 1.0 - self.truncatingRemainder(dividingBy: 1.0) ) }
    
    /// Linear map of self from range [a1...a2] --> [b1...b2]
    func mapLinear<T: BinaryFloatingPoint>(a1: T, a2: T, b1: T, b2: T) -> Self {
        let a11 = Self(a1)
        let a22 = Self(a2)
        let b11 = Self(b1)
        let b22 = Self(b2)
        let x = self - a11
        let y = b22 - b11
        let z = a22 - a11
        return b11 + x * y / z
    }
    
    /// Return self rounded up to min or down to max
    func clamp<T: BinaryFloatingPoint>(min mi: T, max ma: T) -> Self {
        let b = Self(mi)
        let t = Self(ma)
        return max( b, min( t, self ) )
    }
    
    /**
     Returns a value between 0 and 1 which represents the precentage of movement that self has moved between min and max, but smoothed as self approaches min and max
     */
    func smoothStep<T: BinaryFloatingPoint>(min mi: T, max ma: T) -> Self {
        let b = Self(mi)
        let t = Self(ma)
        if self <= b { return 0.0 }
        if self >= t { return 1.0 }
        let dx = ( self - b ) / ( t - b )
        return dx * dx * ( 3.0 - 2.0 * dx )
    }
    
    /**
     Returns a value between 0 and 1 which represents the precentage of movement that self has moved between min and max. Functionally similar to Self.smoothStep, but even smoother.
     */
    func smootherStep<T: BinaryFloatingPoint>(min mi: T, max ma: T) -> Self {
        let b = Self(mi)
        let t = Self(ma)
        if self <= b { return 0.0 }
        if self >= t { return 1.0 }
        let dx = ( self - b ) / ( t - b )
        let derp = dx * dx * dx
        let slurp = self * 6 - 15
        return derp * ( dx * ( slurp ) + 10.0 )
    }
    
    /// Calculate the absolute distance between self and to
    func distance(_ to: Self) -> Self {
        if self < to {
            return abs(to - self)
        } else {
            return abs(self - to)
        }
    }
}
