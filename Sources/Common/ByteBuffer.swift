public typealias ByteBuffer = MutableCollection<UInt8> & RandomAccessCollection<UInt8>

extension MutableCollection<UInt8> where Self: RandomAccessCollection {
    public mutating func withByteSinkAdapterIfAvailable<R>(
        _ body: (inout ByteSinkAdapter) throws -> R
    ) rethrows -> R? {
        try self.withContiguousMutableStorageIfAvailable {
            var adapter = ByteSinkAdapter(buffer: $0)
            return try body(&adapter)
        }
    }
    
    public mutating func withByteSinkAdapter<R>(
        _ body: (inout ByteSinkAdapter) throws -> R
    ) rethrows -> R {
        guard let result = try self.withByteSinkAdapterIfAvailable(body) else {
            preconditionFailure(
                "\(Self.self) does not provide access to contiguous mutable storage"
            )
        }
        return result
    }
}
