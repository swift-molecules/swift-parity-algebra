import Optic
import Testing

@Suite
struct `Optic Iso Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

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
