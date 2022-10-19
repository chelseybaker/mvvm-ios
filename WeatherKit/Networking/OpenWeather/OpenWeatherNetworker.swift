//
//  OpenWeatherNetworker.swift
//  WeatherKit
//
//  Created by Chelsey Baker on 10/18/22.
//

import Foundation
import Alamofire

enum OpenWeatherNetworkerError: Error {
  case BaseUrlInvalid
}

class OpenWeatherNetworker: OpenWeatherNetworking {
  
  private let session: Session
  private let baseUrl: String
  private let apiKey: String
  
  init(apiKey: String,
       baseUrl: String = "https://api.openweathermap.org/data/2.5",
       session: Session = Alamofire.Session.default) {
    
    self.session = session
    self.baseUrl = baseUrl
    self.apiKey = apiKey
  }
  
  func getWeatherForZip(zip: String) -> DataRequest {
    let path = baseUrl + OpenWeatherAPI.GetWeatherForZip(zip: zip, apiKey: apiKey).path
    return session.request(path, method: .get)
  }
  
  func getWeatherForCoordinates(coordinates: Coordinates) -> DataRequest {
    let path = baseUrl + OpenWeatherAPI.GetWeatherForCoordinates(coordinates: coordinates, apiKey: apiKey).path
    return session.request(path, method: .get)
  }
}

enum OpenWeatherAPI {
  case GetWeatherForCoordinates(coordinates: Coordinates, apiKey: String)
  case GetWeatherForZip(zip: String, apiKey: String)
  
  var path: String {
    switch self {
    case .GetWeatherForCoordinates(let coordinates, let apiKey):
      return "/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(apiKey)"
    case .GetWeatherForZip(let zip, let apiKey):
      return "/weather?zip=\(zip)&appid=\(apiKey)"
    }
  }
}
