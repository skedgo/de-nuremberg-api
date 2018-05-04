import Foundation
import Vapor

extension Droplet {
  func setupRoutes() throws {
    
    // Prefer time-stamps to be ISO8601
    let encoder = JSONEncoder()
    if #available(OSX 10.12, *) {
      encoder.dateEncodingStrategy = .iso8601
    } else {
      encoder.dateEncodingStrategy = .secondsSince1970
    }
    
    get("carparks") { req in
      guard let carparks = CarParkDatabase.shared?.carParks.values else {
        return Response(status: .notFound)
      }
      let sorted = Array(carparks)
        .sorted(by: { $0.id < $1.id })
        .map { CarParkRealtimeCache.shared.addingRealTime(to: $0, using: self.client) }
      return try sorted.makeResponse(using: encoder)
    }
    
    get("carparks", String.parameter) { req in
      let id = try req.parameters.next(String.self)
      guard let carPark = CarParkDatabase.shared?.carParks[id] else {
        return Response(status: .notFound)
      }
      let carParkWithAvailability = CarParkRealtimeCache.shared.addingRealTime(to: carPark, using: self.client)
      return try carParkWithAvailability.makeResponse(using: encoder)
    }

    get("carparks", String.parameter, "availability") { req in
      let id = try req.parameters.next(String.self)
      guard let carPark = CarParkDatabase.shared?.carParks[id] else {
        return Response(status: .notFound, body: "No car park exists with id \(id)")
      }
      guard let _ = CarParkDatabase.shared?.carParks[id]?.realTimeId else {
        return Response(status: .notFound, body: "No real-time data available for car park with id \(id)")
      }
      guard let match = try CarParkRealtimeCache.shared.realTime(for: carPark, using: self.client) else {
        return Response(status: .notFound, body: "Real-time data currently not available for car park with id \(id)")
      }

      return try match.makeResponse(using: encoder)
    }

    
    // response to requests to /info domain
    // with a description of the request
    get("info") { req in
        return req.description
    }

    get("description") { req in return req.description }
  }
}
