@_exported
import Common

public protocol Duplex: DuplexProtocol {
    init()
}

public extension Duplex {
    static func hash(
        contentsOf bytes: some ByteSequence,
        to byteSink: inout some ByteSink,
        outputByteCount: Int = Self.defaultOutputByteCount
    ) {
        var duplex: Self = .init()
        duplex.absorb(contentsOf: bytes)
        duplex.squeeze(to: &byteSink, outputByteCount: outputByteCount)
    }
}

extension Duplex where Self: FixedSizeOutputProtocol {
    public static func hash(contentsOf bytes: some ByteSequence) -> FixedSizeOutput {
        var sha1: Self = .init()
        sha1.absorb(contentsOf: bytes)
        return sha1.squeeze()
    }
}
