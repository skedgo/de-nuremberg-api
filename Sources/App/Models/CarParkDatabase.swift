//
//  CarParkDatabase.swift
//  App
//
//  Created by Adrian Schönig on 27.04.18.
//

import Foundation

class CarParkDatabase {
  static var shared: CarParkDatabase?
  
  init(directory: String) throws {
    
    let path = URL(fileURLWithPath: directory)
    let sources = try FileManager.default
      .contentsOfDirectory(at: path, includingPropertiesForKeys: nil, options: [])
      .map(CarParkSource.load)
    
    self.sources = sources
    
    self.carParks = sources
      .flatMap { $0.flattened() }
      .reduce(into: [:]) { (acc: inout [String: CarPark], carPark: CarPark) in
        acc[carPark.id] = carPark
      }
  }
  
  fileprivate let sources: [CarParkSource]
  
  let carParks: [String: CarPark]
  
}

fileprivate struct CarParkSource: Codable {
  let source: CarPark.DataSource
  let list: [CarPark]

  static func load(contentsOf path: URL) throws -> CarParkSource {
    let data = try Data(contentsOf: path)
    return try! JSONDecoder().decode(CarParkSource.self, from: data)
  }
  
  func flattened() -> [CarPark] {
    return list.map { $0.attributing(source) }
  }
}

extension CarPark {
  fileprivate func attributing(_ source: CarPark.DataSource) -> CarPark {
    var updated = self
    updated.source = source
    return updated
  }
}
