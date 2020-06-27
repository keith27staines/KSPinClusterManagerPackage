
import XCTest
import KSPinClusterManagerPackage
import KSGeometryPackage

class KSClusterTestCase: XCTestCase {
    
    let centerPin = KSPin(id: "pinId", x: 1, y: 0)
    
    func test_cluster_initialise() {
        let sut = makeSUT(id: "id")
        XCTAssertEqual(sut.id, "id")
        XCTAssertEqual(sut.centerPin, centerPin)
        XCTAssertEqual(sut.pins.first, centerPin)
        XCTAssertEqual(sut.count, 1)
        XCTAssertEqual(sut.x, centerPin.x)
        XCTAssertEqual(sut.y, centerPin.y)
    }
    
    func test_equality_and_hash() {
        let sut1 = makeSUT(id: "1")
        let sut2 = makeSUT(id: "2")
        XCTAssertNotEqual(sut1, sut2)
        XCTAssertNotEqual(sut1.hashValue, sut2.hashValue)
    }
    
    func test_addPin_not_same() {
        let sut = makeSUT(id: "id0")
        sut.addPin(KSPin(id: "id1", x: 0, y: 0))
        XCTAssertEqual(sut.count, 2)
    }
    
    func test_addPin_same() {
        let sut = makeSUT(id: "id0")
        sut.addPin(centerPin)
        XCTAssertEqual(sut.count, 1)
    }
    
    func test_catchementRectangleWithSize() {
        let size = KSSize(width: 2, height: 3)
        let sut = makeSUT(id: "")
        XCTAssertEqual(
            sut.catchementRectangle(size: size),
            KSRect(center: sut.centerPin.point, size: size)
        )
    }
    
    func makeSUT(id: String) -> KSCluster {
        KSCluster(id: id, centerPin: centerPin)
    }

    
}
