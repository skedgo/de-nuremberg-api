//
//  CarPark.swift
//  App
//
//  Created by Adrian Schönig on 27.04.18.
//

import Foundation

struct CarPark: Codable {
  let id: String
  let lat: CLLocationDegrees
  let lng: CLLocationDegrees
  let name: String
  let link: String
  let realTimeId: String?
  
  let totalSpaces: Int
  let open: String
  let maxHeightInMetres: Double?
  
  let fares: [FareTable]
  
  var source: DataSource?
  
  struct FareTable: Codable {
    let title: String?
    let times: String
    let prices: [Fare]
  }
  
  struct Fare: Codable {
    let type: String?
    let maxDurationInMinutes: Int
    let value: Double
  }
  
  struct DataSource: Codable {
    let name: String
    let website: String?
    let disclaimer: String?
  }
}
