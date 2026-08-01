// Optic Iso Tests.swift

import Optic_Primitives
import Testing

// Smoke coverage for the Optic.Iso transport that the z2-via-iso witnesses rely on.

@Suite
struct `Optic Iso Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

// MARK: - Unit

extension `Optic Iso Tests`.Unit {

    @Test
    func `Optic Iso round-trips`() {
        let toString: Optic.Iso<Int, String> = .init(
            forward: { String($0) },
            backward: { Int($0)! }
        )
        let encoded = toString.forward(7)
        #expect(encoded == "7")
        let decoded = toString.backward(encoded)
        #expect(decoded == 7)
    }
}
