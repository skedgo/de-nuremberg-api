//
//  CarParkDatabaseTests.swift
//  AppTests
//
//  Created by Adrian Schönig on 27.04.18.
//

import Foundation

import XCTest
import Testing
import HTTP
import Sockets
@testable import Vapor
@testable import App

class CarParkDatabaseTests: TestCase {

  func testLoadingCarParks() throws {
    let database = try loadDatabase()
    XCTAssertEqual(24, database.carParks.count)
  }
  
  func testParsingRealtime() throws {
    let realtimes = try loadRealtime()
    XCTAssertEqual(19, realtimes.count)
  }
  
  func testMatching() throws {
    let database = try loadDatabase()
    let realtimes = try loadRealtime()
    
    for carPark in database.carParks.values where carPark.realTimeId != nil {
      let match = realtimes.find(carPark)
      XCTAssertNotNil(match, "No match for \(carPark.realTimeId!)")
    }
  }
  
}

extension CarParkDatabaseTests {
  private func loadDatabase() throws -> CarParkDatabase {
    return try CarParkDatabase(directory: workingDirectory() + "Resources/data/")
  }

  private func loadRealtime() throws -> [CarParkRealtime] {
    let path = URL(fileURLWithPath: workingDirectory() + "Tests/AppTests/Data/plc_info.htm")
    let content = try String(contentsOf: path, encoding: .ascii)
    return PLCRealtimeFetcher.parse(content)
  }
}

// MARK: Manifest

extension CarParkDatabaseTests {
  /// This is a requirement for XCTest on Linux
  /// to function properly.
  /// See ./Tests/LinuxMain.swift for examples
  static let allTests = [
    ("testLoadingCarParks", testLoadingCarParks),
    ("testParsingRealtime", testParsingRealtime),
    ("testMatching", testMatching),
    ]
}
