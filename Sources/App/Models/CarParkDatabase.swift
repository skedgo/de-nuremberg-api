//
//  CarParkDatabase.swift
//  App
//
//  Created by Adrian Schönig on 27.04.18.
//

import Foundation

class CarParkDatabase {
  static var shared: CarParkDatabase?
  
  fileprivate let sources: [CarParkSource]
  
  init(directory: String) throws {
    
    let path = URL(fileURLWithPath: directory)
    sources = try FileManager.default
      .contentsOfDirectory(at: path, includingPropertiesForKeys: nil, options: [])
      .map(CarParkSource.load)
  }
  
  var carParks: [CarPark] {
    return sources.flatMap { $0.list }
  }
}

fileprivate struct CarParkSource: Codable {
  let source: String
  let list: [CarPark]

  static func load(contentsOf path: URL) throws -> CarParkSource {
    let data = try Data(contentsOf: path)
    return try! JSONDecoder().decode(CarParkSource.self, from: data)
  }
}
