public import Algebra_Group
public import Parity

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
