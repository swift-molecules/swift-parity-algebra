import Algebra_Module_Primitives
import Parity_Algebra_Primitives
import Parity_Primitives
import Testing

// [TEST-004] Generic type uses parallel namespace pattern.
//
// `Algebra.Module<Scalars, Vectors>` is an unspecialized generic type, so the
// extension-pattern nested suite hard-errors with `@section cannot be used in
// a generic context`; this uses the top-level backticked-name fallback.

@Suite
struct `Algebra.Module Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

// MARK: - Test Fixtures

extension `Algebra.Module Tests` {
    /// Parity field as scalars, Parity group as vectors.
    ///
    /// Scalar multiplication is Parity.multiplying.
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

// MARK: - Unit

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
