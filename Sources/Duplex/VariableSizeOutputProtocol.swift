public protocol VariableSizeOutputProtocol: DuplexProtocol {
    associatedtype VariableSizeOutput: ByteSequence
    
    mutating func squeeze(outputByteCount: Int) -> VariableSizeOutput
}

extension VariableSizeOutputProtocol
where VariableSizeOutput: ByteBuffer & RangeReplaceableCollection {
    public mutating func squeeze(outputByteCount: Int) -> VariableSizeOutput {
        var output: VariableSizeOutput = .init(repeating: 0, count: outputByteCount)
        self.squeeze(into: &output)
        return output
    }
}
