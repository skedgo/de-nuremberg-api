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
  
  func fetchAndUpdate(completion: @escaping ([CarParkRealtime]) -> Void) {
    guard realtimes.isEmpty else {
      completion(realtimes)
      return
    }
    
    // TODO: Expire results, e.g., if real-times are outdated
    
    PLCRealtime.fetch { new in
      if !new.isEmpty {
        self.realtimes = new
      }
      completion(self.realtimes)
    }
  }
  
}
