//
//  MiniCoreLocation.swift
//  App
//
//  Created by Adrian Schönig on 27.04.18.
//

import Foundation

typealias CLLocationDegrees = Double
typealias CLLocationAccuracy = Double
typealias CLLocationDistance = Double
typealias CLLocationSpeed = Double
typealias CLLocationDirection = Double

struct CLLocationCoordinate2D {
  var latitude: CLLocationDegrees
  var longitude: CLLocationDegrees
  init() {
    latitude = 0
    longitude = 0
  }
  
  init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
    self.latitude = latitude
    self.longitude = longitude
  }
}
