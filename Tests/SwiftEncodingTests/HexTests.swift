import XCTest
@testable import SwiftEncoding

final class HexTests: XCTestCase {
    func testHexEncodeShouldEqualToExpected() throws {
        let expected: String = "446f67e280bcf09f90b6"

        XCTAssertEqual(encodeHex(data: "Dog‼🐶"), expected)
    }

    func testHexEncodeShouldNotEqualToExpected() throws {
        let expected: String = "446f67e280bcf09f90b661"

        XCTAssertNotEqual(encodeHex(data: "Dog‼🐶"), expected)
    }

    func testHexDecodeShouldEqualToExpected() throws {
        let expected: String = "Dog‼🐶"

        do {
            let actual = try decodeHex(data: "446f67e280bcf09f90b6")
            XCTAssertEqual(actual, expected)
        } catch {
            XCTAssertNoThrow(error)
        }
    }

    func testHexDecodeShouldThrowExceptionInvalidHexChar() throws {
        XCTAssertThrowsError(try decodeHex(data: "446f67e280bcf09f90b6µ"))
    }
}
