public import Algebra
public import Optic
public import Parity

extension Algebra.Group.Abelian {

    @inlinable
    public static func z2(via iso: Optic.Iso<Element, Parity>) -> Self {
        .init(group: .z2(via: iso))
    }
}
