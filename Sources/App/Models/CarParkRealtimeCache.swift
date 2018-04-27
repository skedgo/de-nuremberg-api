//
//  CarParkRealtimeCache.swift
//  App
//
//  Created by Adrian Schönig on 27.04.18.
//

import Foundation

class CarParkRealtimeCache {
  
  static let shared = CarParkRealtimeCache()
  
  private init() {
  }
  
  private var realtimes: [CarParkRealtime] = []
  
  func fetchAndUpdate(for droplet: Droplet) throws -> [CarParkRealtime] {
    guard realtimes.isEmpty else {
      return realtimes
    }
    
    // TODO: Expire results, e.g., if real-times are outdated
    
    let new = try PLCRealtimeFetcher.fetch(for: droplet)
    if !new.isEmpty {
      realtimes = new
    }
    return realtimes
  }
  
}
