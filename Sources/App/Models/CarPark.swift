//
//  CarPark.swift
//  App
//
//  Created by Adrian Schönig on 27.04.18.
//

import Foundation

/// Same schema as https://github.com/skedgo/TSP-APIs => car-park.swagger.yaml
struct CarPark: Codable {
  let id: String
  let name: String
  let coordinates: GeoCoordinates
  let link: String
  
  let totalSpotNumber: Int
  let maxHeightInMetres: Double?
  
  let openingHours: [String]
  let fares: [FareTable]
  
  var source: DataSource?

  let realTimeId: String?
  var availability: CarParkRealtime?

  
  struct GeoCoordinates: Codable {
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    let address: String?
  }
  
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
    let amount: Double
  }
  
  struct DataSource: Codable {
    let provider: CompanyInfo
    let disclaimer: String?
  }
  
  struct CompanyInfo: Codable {
    let name: String
    let website: String?
  }
}
