# <img src="api-mark-logo.png" alt="TripGo API" width="30" height="30"> TSP Connectors for Nuremberg, Germany

<p align="center">
    <a href="https://developer.tripgo.com/extensions/">
        <img src="http://img.shields.io/badge/read_the-docs-92A8D1.svg" alt="Documentation">
    </a>
    <a href="LICENSE">
        <img src="http://img.shields.io/badge/license-MIT-brightgreen.svg" alt="MIT License">
    </a>
    <a href="https://travis-ci.org/skedgo/de-nuremberg-api">
    	<img src="https://travis-ci.org/skedgo/de-nuremberg-api.svg?branch=master" alt="Build Status">
    </a>
    <a href="https://swift.org">
        <img src="http://img.shields.io/badge/swift-4.1-brightgreen.svg" alt="Swift 4.1">
    </a>
    <a href="https://vapor.codes">
        <img src="http://img.shields.io/badge/vapor-3.0-brightgreen.svg" alt="Vapor 3.0">
    </a>
</center>


This lightweight web API provides wrappers around transport-related APIs for Nuremberg, Germany, making them compatible with the [TripGo API](https://developer.tripgo.com).

Includes:

- Selected car parks with opening hours and pricing information
- Real-time availability for selected car parks

## Car Park APIs

- Car parks: https://de-nuremberg-api.vapor.cloud/carparks/
- Details for one: https://de-nuremberg-api.vapor.cloud/carparks/{id}/
- Real-time for one: https://de-nuremberg-api.vapor.cloud/carparks/{id}/availability

## Contributing

This is implemented using the [Vapor](https://vapor.codes) framework, running Swift on the server (macOS or Linux). 

Run it from the command line locally using `vapor run` and test it using `vapor test`. On macOS you can also use Xcode, using the "Run" scheme for running the server locally, or using the "de-nuremberg-api-Package" scheme for testing.
