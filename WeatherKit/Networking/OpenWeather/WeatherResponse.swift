//
//  WeatherResponse.swift
//  WeatherKit
//
//  Created by Chelsey Baker on 10/18/22.
//

import Foundation

struct Main: Decodable {
  let temp: Double
}
/// Expected Open Weather response object
/// https://openweathermap.org/api/one-call-3#hist_parameter
struct WeatherResponse: Decodable {
  let main: Main
  let name: String
}
