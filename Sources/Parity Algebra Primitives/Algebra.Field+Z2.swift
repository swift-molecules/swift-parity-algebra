public import Algebra_Field_Primitives
public import Optic_Primitives
public import Parity_Primitives

extension Algebra.Field {

    @inlinable
    public static func z2(via iso: Optic.Iso<Element, Parity>) -> Self {
        return .init(
            additive: .z2(via: iso),
            multiplicative: .init(
                monoid: .init(
                    identity: iso.backward(.odd),
                    combining: { lhs, rhs in
                        iso.backward(Parity.multiplying(iso.forward(lhs), iso.forward(rhs)))
                    }
                )
            ),
            reciprocal: { element throws(Algebra.Field<Element>.Error) in
                guard iso.forward(element) == .odd else { throw .nonInvertible }
                return element
            }
        )
    }
}
