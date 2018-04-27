//
//  PLCRealtime.swift
//  App
//
//  Created by Adrian Schönig on 27.04.18.
//

import Foundation

class PLCRealtime {
  
  enum PLCRealtimeParserError: Error {
    case incompleteRow
  }
  
  private init() {
  }
  
  private static let url = URL(string: "http://tiefbauamt.nuernberg.de/site/parken/parkhausbelegung/plc_info.htm")!
  
  static func fetch(completion: @escaping ([CarParkRealtime]) -> Void) {
    let task = URLSession.shared.dataTask(with: url) { data, _, _ in
      guard let data = data, let string = String(data: data, encoding: .ascii) else {
        completion([])
        return
      }
      
      let carParks = PLCRealtime.parse(string)
      completion(carParks)
    }
    task.resume()
  }
  
  static func parse(_ data: String) -> [CarParkRealtime] {
    let content = data.split(separator: "\r\n").filter { !$0.isEmpty }[3...]
    return content.flatMap { CarParkRealtime(line: String($0)) }
  }
  
}

extension Array where Element == CarParkRealtime {
  func find(_ carPark: CarPark) -> Element? {
    return first { $0.realTimeName.trim() == carPark.realTimeName?.trim() }
  }
}

fileprivate extension CarParkRealtime {
  init?(line: String) {
    let parts = line.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
    guard parts.count >= 6, let total = Int(parts[2]), let available = Int(parts[3]) else {
      return nil
    }
    
    realTimeName = parts[0]
    isOpen = parts[1] == "1"
    totalSpaces = total
    availableSpaces = available
    opens = parts[4]
    closes = parts[5] == "00:00" ? "24:00" : parts[5]
  }
}
