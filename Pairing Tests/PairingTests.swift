
@testable import Pairing
import XCTest

final class PairingTests: XCTestCase {

	func testMapNone() {

		let array = [1, 2, 3]

		let result = array.paired(with: .none)

		XCTAssertEqual(result.count, 2)
		XCTAssertEqual(result[0].0, 1)
		XCTAssertEqual(result[0].1, 2)
		XCTAssertEqual(result[1].0, 2)
		XCTAssertEqual(result[1].1, 3)
	}

	func testMapLastElementFirst() {

		let array = [1, 2, 3]

		let result = array.paired(with: .lastElementFirst)

		XCTAssertEqual(result.count, 3)
		XCTAssertEqual(result[0].0, 3)
		XCTAssertEqual(result[0].1, 1)
		XCTAssertEqual(result[1].0, 1)
		XCTAssertEqual(result[1].1, 2)
		XCTAssertEqual(result[2].0, 2)
		XCTAssertEqual(result[2].1, 3)
	}

	func testMapFirstElementLast() {

		let array = [1, 2, 3]

		let result = array.paired(with: .firstElementLast)

		XCTAssertEqual(result.count, 3)
		XCTAssertEqual(result[0].0, 1)
		XCTAssertEqual(result[0].1, 2)
		XCTAssertEqual(result[1].0, 2)
		XCTAssertEqual(result[1].1, 3)
		XCTAssertEqual(result[2].0, 3)
		XCTAssertEqual(result[2].1, 1)
	}

	// MARK: Empty

	func testMapNoneEmpty() {
		let array: [Int] = []
		let result = array.paired(with: .none)
		XCTAssertEqual(result.count, 0)
	}

	func testMapLastElementFirstEmpty() {
		let array: [Int] = []
		let result = array.paired(with: .lastElementFirst)
		XCTAssertEqual(result.count, 0)
	}

	func testMapFirstElementLastEmpty() {
		let array: [Int] = []
		let result = array.paired(with: .firstElementLast)
		XCTAssertEqual(result.count, 0)
	}

	// MARK: One element

	func testMapNoneOneElement() {
		let array: [Int] = [1]
		let result = array.paired(with: .none)
		XCTAssertEqual(result.count, 0)
	}

	func testMapLastElementFirstOneElement() {
		let array: [Int] = [1]
		let result = array.paired(with: .lastElementFirst)
		XCTAssertEqual(result.count, 0)
	}

	func testMapFirstElementLastOneElement() {
		let array: [Int] = [1]
		let result = array.paired(with: .firstElementLast)
		XCTAssertEqual(result.count, 0)
	}
}
