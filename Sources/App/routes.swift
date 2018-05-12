import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
  
  router.get("carparks") { req throws -> Future<[CarPark]> in
    guard let carparks = CarParkDatabase.shared?.carParks.values else {
      throw Abort(.notFound)
    }
    
    let sorted = Array(carparks).sorted(by: { $0.id < $1.id })
    
    return Future
      .map(on: req) { sorted }
      .flatMap { CarParkRealtimeCache.shared.addingRealTimes(to: $0, using: try req.client()) }
  }
  
  router.get("carparks", String.parameter) { req -> Future<CarPark> in
    let id = try req.parameters.next(String.self)
    guard let carPark = CarParkDatabase.shared?.carParks[id] else {
      throw Abort(.notFound)
    }

    return CarParkRealtimeCache.shared.addingRealTime(to: carPark, using: try req.client())
  }

  router.get("carparks", String.parameter, "availability") { req -> Future<CarParkRealtime> in
    let id = try req.parameters.next(String.self)
    guard let carPark = CarParkDatabase.shared?.carParks[id] else {
      throw Abort(.notFound, reason: "No car park exists with id \(id)")
    }
    guard let _ = CarParkDatabase.shared?.carParks[id]?.realTimeId else {
      throw Abort(.notFound, reason: "No real-time data available for car park with id \(id)")
    }
    
    return CarParkRealtimeCache.shared
      .realTime(for: carPark, using: try req.client())
      .map {
        guard let realtime = $0 else {
          throw Abort(.notFound, reason: "Real-time data currently not available for car park with id \(id)")
        }
        return realtime
      }
  }

}

extension CarPark: Content {}
extension CarParkRealtime: Content {}
