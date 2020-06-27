
import XCTest
import KSGeometryPackage
@testable import KSPinClusterManagerPackage

class KSClusterManagerTestCase: XCTestCase {
    
    let bounds = KSRect(x: -100, y: -100, width: 200, height: 200)
    let testPinBounds = KSRect(x: -0.1, y: -0.1, width: 4.2, height: 4.2)
    let testPins: [KSPin] = [
        KSPin(id: "0", point: KSPoint(x: 0, y: 0)),
        KSPin(id: "1", point: KSPoint(x: 1, y: 0)),
        KSPin(id: "2", point: KSPoint(x: 2, y: 0)),
        KSPin(id: "3", point: KSPoint(x: 3, y: 0)),
        KSPin(id: "4", point: KSPoint(x: 4, y: 0)),
        KSPin(id: "5", point: KSPoint(x: 0, y: 1)),
        KSPin(id: "6", point: KSPoint(x: 1, y: 1)),
        KSPin(id: "7", point: KSPoint(x: 2, y: 1)),
        KSPin(id: "8", point: KSPoint(x: 3, y: 1)),
        KSPin(id: "9", point: KSPoint(x: 4, y: 1)),
        KSPin(id: "10", point: KSPoint(x: 0, y: 2)),
        KSPin(id: "11", point: KSPoint(x: 1, y: 2)),
        KSPin(id: "12", point: KSPoint(x: 2, y: 2)),
        KSPin(id: "13", point: KSPoint(x: 3, y: 2)),
        KSPin(id: "14", point: KSPoint(x: 4, y: 2)),
        KSPin(id: "15", point: KSPoint(x: 0, y: 3)),
        KSPin(id: "16", point: KSPoint(x: 1, y: 3)),
        KSPin(id: "17", point: KSPoint(x: 2, y: 3)),
        KSPin(id: "18", point: KSPoint(x: 3, y: 3)),
        KSPin(id: "19", point: KSPoint(x: 4, y: 3)),
        KSPin(id: "20", point: KSPoint(x: 0, y: 4)),
        KSPin(id: "20", point: KSPoint(x: 1, y: 4)),
        KSPin(id: "20", point: KSPoint(x: 2, y: 4)),
        KSPin(id: "20", point: KSPoint(x: 3, y: 4)),
        KSPin(id: "20", point: KSPoint(x: 4, y: 4)),
    ]
    
    func test_initialise() {
        let sut = ClusterManager(bounds: bounds)
        XCTAssertEqual(sut.pinsQuadTree.count(), 0)
        XCTAssertEqual(sut.clustersQuadTree.count(), 0)
        XCTAssertEqual(sut.pins.count, 0)
    }
    
    func test_insertPin() {
        let sut = ClusterManager(bounds: bounds)
        try! sut.insertPin(KSPin(id: "", point: KSPoint.zero))
        XCTAssertEqual(sut.pinsQuadTree.count(), 1)
        XCTAssertEqual(sut.pins.count, 1)
    }
    
    func test_insertPins() {
        let sut = ClusterManager(bounds: bounds)
        sut.insert(testPins)
        XCTAssertEqual(sut.pinsQuadTree.count(), testPins.count)
        XCTAssertEqual(sut.pins, testPins)
    }
    
    func test_clear() {
        let sut = ClusterManager(bounds: bounds)
        sut.insert(testPins)
        sut.clear()
        XCTAssertEqual(sut.pinsQuadTree.count(), 0)
        XCTAssertEqual(sut.pins.count, 0)
    }
    
    func test_rebuildClusters_with_catchement_smaller_than_pin_separation() {
        let sut = ClusterManager(bounds: bounds)
        sut.insert(testPins)
        sut.rebuildClusters(catchementSize: KSSize.zero, in: testPinBounds)
        XCTAssertEqual(sut.clustersQuadTree.count(), testPins.count)
    }
    
    func test_rebuildClusters_from_two_close_pins() {
        let sut = ClusterManager(bounds: bounds)
        sut.insert([testPins[0],testPins[1]])
        sut.rebuildClusters(catchementSize: KSSize(width: 2.0001, height: 2), in: bounds)
        XCTAssertEqual(sut.clustersQuadTree.count(), 1)
    }
    
    func test_rebuildClusters_from_two_close_pins_one_distant_pin() {
        let sut = ClusterManager(bounds: bounds)
        sut.insert([testPins[0],testPins[1], testPins[4]])
        sut.rebuildClusters(catchementSize: KSSize(width: 2.1, height: 2), in: bounds)
        XCTAssertEqual(sut.clustersQuadTree.count(), 2)
    }
    
    func test_getClusters() {
        let sut = ClusterManager(bounds: bounds)
        sut.insert(testPins)
        sut.rebuildClusters(catchementSize: bounds.size, in: bounds)
        XCTAssertEqual(sut.getClusters().count, testPins.count)
    }
    
}
