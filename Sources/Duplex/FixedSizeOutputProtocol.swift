@_exported
import Common

public protocol FixedSizeOutputProtocol: DuplexProtocol {
    associatedtype FixedSizeOutput: ByteSequence
    
    mutating func squeeze() -> FixedSizeOutput
}

extension FixedSizeOutputProtocol where FixedSizeOutput: ByteBuffer & RangeReplaceableCollection {
    public mutating func squeeze() -> FixedSizeOutput {
        var output: FixedSizeOutput = .init(repeating: 0, count: Self.defaultOutputByteCount)
        self.squeeze(into: &output)
        return output
    }
}
