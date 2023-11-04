# VectorProtocol

# Archive Notice
This repository is now archived. The algorithms in this Swift package are not performant and it is recommended that you use [SIMDExtensions](https://github.com/robertmsale/SIMDExtensions) if you are looking for an explicitly typed way of doing vector arithmetic. SIMD is made easy with Apple's framework, and SIMDExtensions is an API that cuts down on the effort of reading through code documentation to figure out what c-style SIMD function will work with what SIMD types. It also includes utilities similar to the ones present in this project. This repository will remain here for educational purposes because it showcases the power of the protocol-oriented nature of Swift.

This swift package defines protocols that provide useful default implementations for various Vector data types. Thanks to Swift's protocol composition, you can apply these protocols and gain incredibly useful vector functions. This package is a dependency of the [VectorExtensions](https://github.com/robertmsale/VectorExtensions) package, which is a core component powering [FieldFab](https://fieldfab.net) for iOS.

## Usage

```
import VectorProtocol

struct <# Vector Type #>: Vector {
    public typealias BFP = <# BinaryFloatingPoint #>
    public typealias Axis = <# Axis Enumeration #> // Enum must conform to Axis protocol
    public subscript(axis: Axis) -> BFP {
        get {
            switch axis {
                <# Get Accessor Cases #>
            }
        }
        set(v) {
            switch axis {
                <# Set Accessor Cases #>
            }
        }
    }
}

// Or as an extension of an existing vector type

extension SCNVector3: Vector {
    // Same code as above
}
```

This package is licensed with the extremely permissive MIT License. 
