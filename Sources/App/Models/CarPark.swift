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
  var availability: CarParkRealtime?
  
  struct FareTable: Codable {
    /// A human-friendly description of this fare table
    let title: String?
    
    /// Used when these fares only apply under certain conditions,
    /// e.g., only for customers, or only for motorcycles, or only
    /// during events.
    let category: String?
    
    /// Machine-friendly string when these fares apply, e.g., '24/7'
    /// 'Mo-Fr 06:00-23:00' or '06:00-23:00'
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
