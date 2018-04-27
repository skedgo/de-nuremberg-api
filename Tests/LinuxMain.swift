#if os(Linux)

import XCTest
@testable import AppTests

XCTMain([
    // AppTests
    testCase(CarParkDatabaseTests.allTests),
    testCase(RouteTests.allTests)
])

#endif
