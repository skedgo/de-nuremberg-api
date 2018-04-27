<p align="center">
    <img src="https://cloud.githubusercontent.com/assets/1342803/24797159/52fb0d88-1b90-11e7-85a5-359fff0496a4.png" width="320" alt="MySQL">
    <br>
    <br>
    <a href="https://developer.tripgo.com/extensions/">
        <img src="http://img.shields.io/badge/read_the-docs-92A8D1.svg" alt="Documentation">
    </a>
    <a href="http://vapor.team">
        <img src="http://vapor.team/badge.svg" alt="Slack Team">
    </a>
    <a href="LICENSE">
        <img src="http://img.shields.io/badge/license-MIT-brightgreen.svg" alt="MIT License">
    </a>
    <a href="https://travis-ci.org/skedgo/de-nuremberg-api">
    	<img src="https://travis-ci.org/skedgo/de-nuremberg-api.svg?branch=master" alt="Build Status">
    </a>
    <a href="https://swift.org">
        <img src="http://img.shields.io/badge/swift-4.0-brightgreen.svg" alt="Swift 4.0">
    </a>
</center>

# TSP Connectors for Nuremberg, Germany

This lightweight web API provides wrappers around transport-related APIs for Nuremberg, Germany, making them compatible with the [TripGo API](https://developer.tripgo.com).

Includes:

- Selected car parks with opening hours and pricing information
- Real-time availability for selected car parks

## Car Park APIs

- Car parks: https://de-nuremberg-api.vapor.cloud/carparks/
- Details for one: https://de-nuremberg-api.vapor.cloud/carparks/{id}/
- Real-time for one: https://de-nuremberg-api.vapor.cloud/carparks/{id}/availability
