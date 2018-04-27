//
//  Array+CarParkRealtime.swift
//  App
//
//  Created by Adrian Schönig on 27.04.18.
//

import Foundation

extension Array where Element == CarParkRealtime {
  func find(_ carPark: CarPark) -> Element? {
    return first { $0.realTimeId.trim() == carPark.realTimeId?.trim() }
  }
  
  var oldestUpdate: Date? {
    return reduce(nil) { oldest, current in
      guard let oldest = oldest else { return current.lastUpdated }
      return current.lastUpdated < oldest ? current.lastUpdated : oldest
    }
  }
}
