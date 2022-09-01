import Duplex
import XCTest

final class DuplexTests: XCTestCase {
    func testExample() throws {
        var duplex: TestDuplex = .init()
        
        duplex.absorb(contentsOf: 0...255)
        
        var byteSink: [UInt8] = []
        duplex.squeeze(to: &byteSink)
        XCTAssertEqual(byteSink, [0, 1, 2, 3])
        
        var byteBuffer: [UInt8] = .init(repeating: 9, count: 6)
        duplex.squeeze(into: &byteBuffer[1...4])
        XCTAssertEqual(byteBuffer, [9, 4, 5, 6, 7, 9])
    }
}
