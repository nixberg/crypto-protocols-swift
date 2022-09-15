public protocol DuplexProtocol {
    static var defaultOutputByteCount: Int { get }
    
    mutating func absorb(contentsOf bytes: some ByteSequence)
    
    mutating func squeeze(to byteSink: inout some ByteSink, outputByteCount: Int)
}

extension DuplexProtocol {
    public mutating func absorb(_ byte: UInt8) {
        self.absorb(contentsOf: CollectionOfOne(byte))
    }
    
    public mutating func squeeze(to byteSink: inout some ByteSink) {
        self.squeeze(to: &byteSink, outputByteCount: Self.defaultOutputByteCount)
    }
    
    /// Note: Requires access to contiguous storage currently.
    public mutating func squeeze(into byteBuffer: inout some ByteBuffer) {
        let outputByteCount = byteBuffer.count
        byteBuffer.withByteSinkAdapter {
            self.squeeze(to: &$0, outputByteCount: outputByteCount)
        }
    }
}
