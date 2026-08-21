public import Algebra_Field_Primitives
public import Parity_Primitives

extension Algebra.Field where Element == Parity {

    @inlinable
    public static var z2: Self {
        .init(
            additive: .init(
                group: .init(
                    identity: .even,
                    combining: Parity.adding,
                    inverting: { $0 }
                )
            ),
            multiplicative: .init(
                monoid: .init(
                    identity: .odd,
                    combining: Parity.multiplying
                )
            ),
            reciprocal: { element throws(Algebra.Field<Parity>.Error) in
                guard element == .odd else { throw .nonInvertible }
                return element
            }
        )
    }
}
