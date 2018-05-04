//
//  PLCRealtime.swift
//  App
//
//  Created by Adrian Schönig on 27.04.18.
//

import Foundation
import Vapor

class PLCRealtimeFetcher {
  
  enum PLCRealtimeParserError: Error {
    case unexpectedResponse
    case incompleteRow
  }
  
  private init() {
  }
  
  private static let endpoint = "http://tiefbauamt.nuernberg.de/site/parken/parkhausbelegung/plc_info.htm"
  
  static func fetch(using client: ClientFactoryProtocol) throws -> [CarParkRealtime] {
    
    let response = try client.get(endpoint)
    guard case .data(let bytes) = response.body else {
      throw PLCRealtimeParserError.unexpectedResponse
    }
    
    let data = Data(bytes: bytes)
    guard let string = String(data: data, encoding: .ascii) else {
      throw PLCRealtimeParserError.unexpectedResponse
    }

    return PLCRealtimeFetcher.parse(string)
  }
  
  static func parse(_ data: String) -> [CarParkRealtime] {
    let content = data.split(separator: "\r\n").filter { !$0.isEmpty }[3...]
    return content.flatMap { CarParkRealtime(line: String($0)) }
  }
  
}

fileprivate extension CarParkRealtime {
  init?(line: String) {
    let parts = line.split(separator: ",").map { String($0).trim() }
    guard parts.count >= 6, let total = Int(parts[2]), let available = Int(parts[3]) else {
      return nil
    }
    
    realTimeId = parts[0]
    isOpen = parts[1] == "1"
    totalSpaces = total
    availableSpaces = available
    opens = parts[4]
    closes = parts[5] == "00:00" ? "24:00" : parts[5]
    
    source = CarPark.DataSource(name: "Stadt Nürnberg", website: "http://www.tiefbauamt.nuernberg.de/site/parken/parkhausbelegung/parkhaus_belegung.html", disclaimer: nil)
  }
}
