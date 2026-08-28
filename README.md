# Parity Algebra

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Z₂ algebra witnesses for `Parity` — the canonical group and field over `{even, odd}`, plus transport of that structure onto any two-element type through an `Optic.Iso`.

---

## Quick Start

`Parity` is the two-element type `{even, odd}`, and it carries the smallest non-trivial algebra: the field GF(2), where addition is XOR and multiplication is AND. This package supplies that algebra as concrete witness values — `Algebra.Field<Parity>.z2`, `Algebra.Group<Parity>.additive` — so consumers reach for a ready-made structure instead of re-deriving the operation tables.

```swift
import Parity_Algebra

// The canonical Z₂ field: Parity under XOR addition and AND multiplication.
let gf2 = Algebra.Field<Parity>.z2

gf2.adding(.odd, .odd)         // .even   (odd + odd = even)
gf2.multiplying(.odd, .odd)    // .odd    (odd × odd = odd)
gf2.zero                       // .even   (additive identity)
gf2.one                        // .odd    (multiplicative identity)
```

Any type with exactly two inhabitants is isomorphic to `Parity`, so the same structure transports onto it. Give `z2(via:)` an `Optic.Iso` and you get the Z₂ field (or group) on the foreign type, with every operation routed through the isomorphism:

```swift
import Parity_Algebra

// Carry the Z₂ structure onto Bool via an isomorphism with Parity.
let toBool: Optic.Iso<Bool, Parity> = .init(
    forward: { $0 ? .odd : .even },
    backward: { $0 == .odd }
)

let field = Algebra.Field<Bool>.z2(via: toBool)

field.adding(true, true)       // false   (transported XOR)
field.one                      // true    (multiplicative identity, the image of .odd)
```

The additive group and the abelian group transport the same way, via `Algebra.Group.z2(via:)` and `Algebra.Group.Abelian.z2(via:)`.

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-molecules/swift-parity-algebra.git", branch: "main")
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Parity Algebra", package: "swift-parity-algebra"),
    ]
)
```

Requires Swift 6.4 and macOS 27 / iOS 27 / tvOS 27 / watchOS 27 / visionOS 27 (or the matching Linux / Windows toolchain).

---

## Architecture

Two library products. Builds on the canonical `Parity`, `Algebra`, and `Optic` atoms, and re-exports them so a single import suffices.

| Product | Target | Purpose |
|---------|--------|---------|
| `Parity Algebra` | `Sources/Parity Algebra/` | The Z₂ witnesses for `Parity`: `Algebra.Field<Parity>.z2`, `Algebra.Group<Parity>.additive`, and the iso-transported `Algebra.Field`, `Algebra.Group`, and `Algebra.Group.Abelian` constructed by `z2(via:)`. |
| `Parity Algebra Test Support` | `Tests/Support/` | Re-exports the main target for test consumers. |

Foundation-free.

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS 27 | Full support |
| Linux | Full support |
| Windows | Full support |
| iOS / tvOS / watchOS / visionOS | Supported |

---

## Community

<!-- BEGIN: discussion -->
<!-- Discussion thread created at publication. -->
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
