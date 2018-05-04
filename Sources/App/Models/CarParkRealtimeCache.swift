//
//  CarParkRealtimeCache.swift
//  App
//
//  Created by Adrian Schönig on 27.04.18.
//

import Foundation

class CarParkRealtimeCache {
  
  static let shared = CarParkRealtimeCache()
  
  private init() { }
  
  private var realtimes: [CarParkRealtime] = []
  
  private func fetchAndUpdate(using client: ClientFactoryProtocol) throws -> [CarParkRealtime] {
    if let oldest = realtimes.oldestUpdate, oldest.timeIntervalSinceNow > -15 * 60 {
      // Re-use results if we have them and they aren't older than 15 mins
      return realtimes
    }
    
    let new = try PLCRealtimeFetcher.fetch(using: client)
    if !new.isEmpty {
      realtimes = new
    }
    return realtimes
  }
  
}

extension CarParkRealtimeCache {
  
  func realTime(for carPark: CarPark, using client: ClientFactoryProtocol) throws -> CarParkRealtime? {
    let realtimes = try CarParkRealtimeCache.shared.fetchAndUpdate(using: client)
    return realtimes.find(carPark)
  }

  func addingRealTime(to carPark: CarPark, using client: ClientFactoryProtocol) -> CarPark {
    guard let realtimes = try? CarParkRealtimeCache.shared.fetchAndUpdate(using: client) else { return carPark }
    var updated = carPark
    updated.availability = realtimes.find(updated)
    return updated
  }

  
}
