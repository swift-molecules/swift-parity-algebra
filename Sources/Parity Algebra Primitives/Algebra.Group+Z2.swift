public import Algebra_Group_Primitives
public import Optic_Primitives
public import Parity_Primitives

extension Algebra.Group {

    @inlinable
    public static func z2(via iso: Optic.Iso<Element, Parity>) -> Self {
        .init(
            identity: iso.backward(.even),
            combining: { lhs, rhs in
                iso.backward(Parity.adding(iso.forward(lhs), iso.forward(rhs)))
            },
            inverting: { $0 }
        )
    }
}
