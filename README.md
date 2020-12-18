# VectorProtocol

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
