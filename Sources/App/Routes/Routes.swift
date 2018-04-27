import Vapor

extension Droplet {
  func setupRoutes() throws {
    get("hello") { req in
        var json = JSON()
        try json.set("hello", "world")
        return json
    }
    
    get("carparks") { req in
      guard let carparks = CarParkDatabase.shared?.carParks else {
        return Response(status: .notFound)
      }
      return try carparks.makeResponse()
    }

    get("plaintext") { req in
        return "Hello, world!"
    }

    // response to requests to /info domain
    // with a description of the request
    get("info") { req in
        return req.description
    }

    get("description") { req in return req.description }
  
    try resource("posts", PostController.self)
  }
}
