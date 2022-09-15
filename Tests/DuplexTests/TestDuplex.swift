import Duplex

struct TestDuplex: Duplex {
    typealias State = [UInt8]
    
    static var defaultOutputByteCount = 4
    
    private var state: State
    private var index: State.Index
    
    init() {
        state = []
        index = state.startIndex
    }
    
    mutating func absorb(contentsOf bytes: some ByteSequence) {
        state.append(contentsOf: bytes)
    }
    
    mutating func squeeze(to byteSink: inout some ByteSink, outputByteCount: Int) {
        let unreadState = state[index...]
        precondition(unreadState.count >= outputByteCount)
        for byte in unreadState.prefix(outputByteCount) {
            byteSink.write(byte)
        }
        index += outputByteCount
    }
}
