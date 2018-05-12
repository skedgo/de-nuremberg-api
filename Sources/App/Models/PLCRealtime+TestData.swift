//
//  PLCRealtime+TestData.swift
//  App
//
//  Created by Adrian Schönig on 12.05.18.
//

import Foundation

import Vapor

extension PLCRealtimeFetcher {

  static func loadTestData(for container: Container) throws -> [CarParkRealtime] {
    let path = try container.make(DirectoryConfig.self).workDir + "Tests/AppTests/Data/plc_info.htm"
    let fileURL = URL(fileURLWithPath: path)
    let content = try String(contentsOf: fileURL, encoding: .ascii)
    return PLCRealtimeFetcher.parse(content)
  }

  
}
