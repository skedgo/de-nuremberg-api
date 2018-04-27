//
//  CarParkRealtime.swift
//  App
//
//  Created by Adrian Schönig on 27.04.18.
//

import Foundation

struct CarParkRealtime: Codable {
  let realTimeName: String
  
  let isOpen: Bool
  let totalSpaces: Int
  let availableSpaces: Int
  
  let opens: String
  let closes: String
  
  var lastUpdated = Date()
}
