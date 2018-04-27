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
  
  func fetchAndUpdate(for droplet: Droplet) throws -> [CarParkRealtime] {
    if let oldest = realtimes.oldestUpdate, oldest.timeIntervalSinceNow > -15 * 60 {
      // Re-use results if we have them and they aren't older than 15 mins
      return realtimes
    }
    
    let new = try PLCRealtimeFetcher.fetch(for: droplet)
    if !new.isEmpty {
      realtimes = new
    }
    return realtimes
  }
  
}
