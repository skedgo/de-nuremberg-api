import Vapor
import XCTest

@testable import App

/// This file shows an example of testing 
/// routes through the Droplet.

class RouteTests: XCTestCase {

  let app = try! Application.testable()

  func testCarParks() throws {
    let response = try app.getResponse(to: "carparks", decodeTo: [CarPark].self)
    XCTAssertEqual(24, response.count)
  }

  func testIndividualCarPark() throws {
    let response = try app.getResponse(to: "carparks/karstadt", decodeTo: CarPark.self)
    XCTAssertEqual(376, response.totalSpotNumber)
    XCTAssertEqual(217, response.availableSpotNumber)
    XCTAssertEqual(217, response.availability?.availableSpaces)
  }
}

// MARK: Manifest

extension RouteTests {
    /// This is a requirement for XCTest on Linux
    /// to function properly.
    /// See ./Tests/LinuxMain.swift for examples
    static let allTests = [
        ("testCarParks", testCarParks),
        ("testIndividualCarPark", testIndividualCarPark),
    ]
}
