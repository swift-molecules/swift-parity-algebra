public import Algebra_Group_Primitives
public import Optic_Primitives
public import Parity_Primitives

extension Algebra.Group.Abelian {

    @inlinable
    public static func z2(via iso: Optic.Iso<Element, Parity>) -> Self {
        .init(group: .z2(via: iso))
    }
}
