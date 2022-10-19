//
//  OpenWeatherNetworking.swift
//  WeatherKit
//
//  Created by Chelsey Baker on 10/18/22.
//

import Foundation
import Alamofire

/// Protocol for Open Weather API calls
/// https://openweathermap.org/api/one-call-3
protocol OpenWeatherNetworking {
  /// Returns the weather for a zip code
  func getWeatherForZip(zip: String) -> DataRequest
  
  /// Returns the weather for a coordinate
  func getWeatherForCoordinates(coordinates: Coordinates) -> DataRequest
}
