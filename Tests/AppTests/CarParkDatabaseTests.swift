//
//  CarParkDatabaseTests.swift
//  AppTests
//
//  Created by Adrian Schönig on 27.04.18.
//

import Foundation

import Vapor
import XCTest

@testable import App

class CarParkDatabaseTests: XCTestCase {

  let app = try! Application.testable()
  
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
    let path = try app.make(DirectoryConfig.self).workDir + "Resources/data/"
    return try CarParkDatabase(directory: path)
  }

  private func loadRealtime() throws -> [CarParkRealtime] {
    return try PLCRealtimeFetcher.loadTestData(for: app)
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
