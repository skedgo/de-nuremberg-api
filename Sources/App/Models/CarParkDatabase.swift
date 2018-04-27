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
      .flatMap { $0.list }
      .reduce(into: [:]) { (acc: inout [String: CarPark], carPark: CarPark) in
        acc[carPark.id] = carPark
      }
  }
  
  fileprivate let sources: [CarParkSource]
  
  let carParks: [String: CarPark]
  
}

fileprivate struct CarParkSource: Codable {
  let source: String
  let list: [CarPark]

  static func load(contentsOf path: URL) throws -> CarParkSource {
    let data = try Data(contentsOf: path)
    return try! JSONDecoder().decode(CarParkSource.self, from: data)
  }
}
