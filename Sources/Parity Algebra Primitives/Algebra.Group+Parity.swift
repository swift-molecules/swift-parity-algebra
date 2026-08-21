public import Algebra_Group_Primitives
public import Parity_Primitives

extension Algebra.Group where Element == Parity {

    @inlinable
    public static var additive: Self {
        .init(
            identity: .even,
            combining: Parity.adding,
            inverting: { $0 }
        )
    }
}
