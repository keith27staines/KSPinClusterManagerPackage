
import XCTest
import KSPinClusterManagerPackage
import KSGeometryPackage

class KSPinTestCase: XCTestCase {
    
    func test_pin_initialise_with_point() {
        let sut = KSPin(id: "id", point: KSPoint(x: 1, y: 2))
        XCTAssertEqual(sut.id, "id")
        XCTAssertEqual(sut.point, KSPoint(x: 1, y: 2))
    }
    
    func test_pin_initialise_with_coordinates() {
        XCTAssertEqual(KSPin(id: "id", x: 1, y: 2), KSPin(id: "id", point: KSPoint(x: 1, y: 2)))
    }
}
