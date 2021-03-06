import XCTest

import La
import LaAccelerate

final class Matrix1x1Tests: XCTestCase, Tests {
    func testScalar() {
        let x: Float = 10
        let m = Matrix<_1, _1, Float>.create([x])!
        XCTAssertEqual(m.scalar, x)
    }

    static let allTests: [(String, (Matrix1x1Tests) -> () -> ())] = [
        ("testScalar", testScalar),
    ]
}
