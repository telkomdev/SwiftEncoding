import XCTest
@testable import SwiftEncoding

final class Base64Tests: XCTestCase {
    func testBase64EncodeShouldEqualToExpected() throws {
        let expected: String = "d3VyaXlhbnRv"

        XCTAssertEqual(encodeBase64(data: "wuriyanto"), expected)
    }

    func testBase64EncodeShouldNotEqualToExpected() throws {
        let expected: String = "d3VyaXlhbnRvcw=="

        XCTAssertNotEqual(encodeBase64(data: "wuriyanto"), expected)
    }

    func testBase64DecodeShouldEqualToExpected() throws {
        let expected: String = "wuriyanto"

        do {
            let actual = try decodeBase64(data: "d3VyaXlhbnRv")
            XCTAssertEqual(actual, expected)
        } catch {
            XCTAssertNoThrow(error)
        }
    }

    func testBase64DecodeShouldThrowExceptionInvalidBase64Char() throws {
        XCTAssertThrowsError(try decodeBase64(data: "d3VyaXlh=bnRv"))
    }
}
