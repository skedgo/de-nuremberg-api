@_exported import Vapor

extension Droplet {
  public func setup() throws {
    try setupRoutes()
    
    CarParkDatabase.shared = try CarParkDatabase(directory: workingDirectory() + "Resources/data/")
  }
}
