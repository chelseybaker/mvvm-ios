//
//  OpenWeatherNetworkerTestCase.swift
//  WeatherKitTests
//
//  Created by Chelsey Baker on 10/18/22.
//

import XCTest
import Alamofire
@testable import WeatherKit

class OpenWeatherNetworkerTestCase: XCTestCase {
  
  var networker: OpenWeatherNetworker!
  
  override func setUpWithError() throws {
    MockURLProtocol.clearHandlers()
    
    let configuration = URLSessionConfiguration.af.default
    configuration.protocolClasses = [MockURLProtocol.self]
    let session = Alamofire.Session(configuration: configuration)
    
    networker = OpenWeatherNetworker(apiKey: "mock-api-key", baseUrl: "http://localhost:8080", session: session)
  }
  
  func test_getWeatherByCoordinatesRequest() {
    // Given we are getting weather by zip code
    // Then the URL should be formatted with the lat long coordinates
    // Then it should be a GET request
    let expectation = expectation(description: "Awaiting responseData")
    
    MockURLProtocol.set(statusCode: 200, jsonStringData: "")
    
    let _ = networker
      .getWeatherForCoordinates(coordinates: Coordinates(longitude: 123, latitude: 456))
      .responseData { (data) in
        XCTAssertEqual(data.request?.method, .get)
        XCTAssertEqual(data.request?.url?.absoluteString, "http://localhost:8080/weather?lat=456.0&lon=123.0&appid=mock-api-key")
        expectation.fulfill()
      }
    
    wait(for: [expectation], timeout: 5)
  }
  
  func test_getWeatherByZipRequest() {
    // Given we are getting weather by zip code
    // Then the URL should be formatted with zip and API key
    // Then it should be a GET request
    let expectation = expectation(description: "Awaiting responseData")
    
    MockURLProtocol.set(statusCode: 200, jsonStringData: "")
    
    let _ = networker
      .getWeatherForZip(zip: "mock-zip")
      .responseData { (data) in
        XCTAssertEqual(data.request?.method, .get)
        XCTAssertEqual(data.request?.url?.absoluteString, "http://localhost:8080/weather?zip=mock-zip&appid=mock-api-key")
        expectation.fulfill()
      }
    
    wait(for: [expectation], timeout: 5)
  }
  
}
