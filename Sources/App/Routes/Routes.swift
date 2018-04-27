import Vapor

extension Droplet {
  func setupRoutes() throws {
    
    get("carparks") { req in
      guard let carparks = CarParkDatabase.shared?.carParks.values else {
        return Response(status: .notFound)
      }
      let sorted = Array(carparks).sorted(by: { $0.id < $1.id })
      return try sorted.makeResponse()
    }
    
    get("carparks", String.parameter) { req in
      let id = try req.parameters.next(String.self)
      guard let carPark = CarParkDatabase.shared?.carParks[id] else {
        return Response(status: .notFound)
      }
      return try carPark.makeResponse()
    }

    get("carparks", String.parameter, "availability") { req in
      let id = try req.parameters.next(String.self)
      guard let carPark = CarParkDatabase.shared?.carParks[id] else {
        return Response(status: .notFound, body: "No car park exists with id \(id)")
      }
      guard let _ = CarParkDatabase.shared?.carParks[id]?.realTimeName else {
        return Response(status: .notFound, body: "No real-time data available for car park with id \(id)")
      }
      
      let realtimes = try CarParkRealtimeCache.shared.fetchAndUpdate(for: self)

      guard let match = realtimes.find(carPark) else {
        return Response(status: .notFound, body: "Real-time data currently not available for car park with id \(id)")
      }

      // TODO: Use a dedicated model for this with nicer output?
      return try match.makeResponse()
    }

    
    // response to requests to /info domain
    // with a description of the request
    get("info") { req in
        return req.description
    }

    get("description") { req in return req.description }
  }
}
