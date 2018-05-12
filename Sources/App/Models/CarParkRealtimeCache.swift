//
//  CarParkRealtimeCache.swift
//  App
//
//  Created by Adrian Schönig on 27.04.18.
//

import Foundation
import Vapor

class CarParkRealtimeCache {
  
  static let shared = CarParkRealtimeCache()
  
  private init() { }
  
  var realtimes: [CarParkRealtime] = []
  
  private func fetchAndUpdate(using client: Client) -> Future<[CarParkRealtime]> {
    guard client.container.environment != .testing else {
      return cachedRealtimes(for: client.container)
    }
    
    if let oldest = realtimes.oldestUpdate, oldest.timeIntervalSinceNow > -15 * 60 {
      // Re-use results if we have them and they aren't older than 15 mins
      return cachedRealtimes(for: client.container)
    }
    
    return PLCRealtimeFetcher.fetch(using: client)
      .do { new in
        if !new.isEmpty {
          CarParkRealtimeCache.shared.realtimes = new
        }
    }
  }
  
  private func cachedRealtimes(for container: Container) -> Future<[CarParkRealtime]> {
    let promise = container.eventLoop.newPromise([CarParkRealtime].self)
    promise.succeed(result: realtimes)
    return promise.futureResult
  }
  
}

extension CarParkRealtimeCache {
  
  func realTime(for carPark: CarPark, using client: Client) -> Future<CarParkRealtime?> {
    return CarParkRealtimeCache.shared
      .fetchAndUpdate(using: client)
      .map { $0.find(carPark) }
  }
  
  func addingRealTime(to carPark: CarPark, using client: Client) -> Future<CarPark> {
    return CarParkRealtimeCache.shared
      .fetchAndUpdate(using: client)
      .map { $0.find(carPark) }
      .map { carPark.adding($0) }
  }
  
  func addingRealTimes(to carParks: [CarPark], using client: Client) -> Future<[CarPark]> {
    return CarParkRealtimeCache.shared
      .fetchAndUpdate(using: client)
      .map { realtimes in
        carParks.map { $0.addingRealTime(from: realtimes) }
    }
  }
  
}

extension CarPark {
  
  fileprivate func addingRealTime(from realtimes: [CarParkRealtime]) -> CarPark {
    let realtime = realtimes.find(self)
    return adding(realtime)
  }
  
  fileprivate func adding(_ realtime: CarParkRealtime?) -> CarPark {
    guard let realtime = realtime else { return self }
    var updated = self
    updated.availability = realtime
    return updated
  }
  
}
