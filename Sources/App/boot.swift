import Vapor

/// Called after your application has initialized.
public func boot(_ app: Application) throws {

  let path = try app.make(DirectoryConfig.self).workDir + "Resources/data/"
  CarParkDatabase.shared = try CarParkDatabase(directory: path)

  if app.environment == .testing {
    CarParkRealtimeCache.shared.realtimes = try PLCRealtimeFetcher.loadTestData(for: app)
  }
}
