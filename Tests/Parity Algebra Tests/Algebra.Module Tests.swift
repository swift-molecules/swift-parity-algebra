import Algebra
import Parity_Algebra
import Parity
import Testing

@Suite
struct `Algebra.Module Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

extension `Algebra.Module Tests` {

    fileprivate static var parityModule: Algebra.Module<Parity, Parity> {
        let ring = Algebra.Ring<Parity>(
            additive: .init(
                group: .init(
                    identity: .even,
                    combining: Parity.adding,
                    inverting: { $0 }
                )
            ),
            multiplicative: .init(
                identity: .odd,
                combining: Parity.multiplying
            )
        )
        return .init(
            scalars: ring,
            vectors: .init(
                group: .init(
                    identity: .even,
                    combining: Parity.adding,
                    inverting: { $0 }
                )
            ),
            scaling: Parity.multiplying
        )
    }

    fileprivate static var parityVectorSpace: Algebra.VectorSpace<Parity, Parity> {
        let field = Algebra.Field<Parity>.z2
        return .init(
            scalars: field,
            vectors: .init(
                group: .init(
                    identity: .even,
                    combining: Parity.adding,
                    inverting: { $0 }
                )
            ),
            scaling: Parity.multiplying
        )
    }
}

extension `Algebra.Module Tests`.Unit {
    @Test
    func `module stores components`() {
        let m = `Algebra.Module Tests`.parityModule
        #expect(m.zero == .even)
        #expect(m.one == .odd)
    }

    @Test
    func `module convenience methods`() {
        let m = `Algebra.Module Tests`.parityModule
        #expect(m.adding(.odd, .odd) == .even)
        #expect(m.negating(.odd) == .odd)
    }

    @Test
    func `vector space stores components`() {
        let vs = `Algebra.Module Tests`.parityVectorSpace
        #expect(vs.zero == .even)
    }

    @Test
    func `vector space convenience methods`() {
        let vs = `Algebra.Module Tests`.parityVectorSpace
        #expect(vs.adding(.odd, .odd) == .even)
        #expect(vs.subtracting(.odd, .odd) == .even)
        #expect(vs.negating(.odd) == .odd)
    }

    @Test
    func `vector space projects to module`() {
        let vs = `Algebra.Module Tests`.parityVectorSpace
        let m = vs.module
        #expect(m.zero == .even)
        #expect(m.one == .odd)
    }
}
