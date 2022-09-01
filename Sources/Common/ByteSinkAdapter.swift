public struct ByteSinkAdapter: ByteSink {
    // TODO: Use safe (`shared` generic) type when that’s possible.
    typealias Buffer = UnsafeMutableBufferPointer<UInt8>
    
    private let buffer: Buffer
    
    private let indices: Buffer.Indices
    
    private var index: Buffer.Index
    
    init(buffer: Buffer) {
        self.buffer = buffer
        indices = buffer.indices
        index = buffer.startIndex
    }
    
    public mutating func write(_ byte: UInt8) {
        precondition(indices.contains(index), "Index out of range")
        buffer[index] = byte
        index += 1
    }
}
