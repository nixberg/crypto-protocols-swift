public protocol ByteSink {
    mutating func write(_ byte: UInt8)
}

extension ByteSink {
    public mutating func write(contentsOf bytes: some ByteSequence) {
        for byte in bytes {
            self.write(byte)
        }
    }
}

extension RangeReplaceableCollection<UInt8> {
    public mutating func write(_ byte: UInt8) {
        self.append(byte)
    }
    
    public mutating func write(contentsOf bytes: some ByteSequence) {
        self.append(contentsOf: bytes)
    }
}

extension Array<UInt8>: ByteSink {}

extension ArraySlice<UInt8>: ByteSink {}

extension ContiguousArray<UInt8>: ByteSink {}

extension Slice: ByteSink where Base: RangeReplaceableCollection<UInt8> {}
