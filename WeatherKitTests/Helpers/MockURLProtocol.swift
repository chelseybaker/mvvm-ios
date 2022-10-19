//
//  MockURLProtocol.swift
//  WeatherKitTests
//
//  Created by Chelsey Baker on 10/18/22.
//

import Foundation

/// Mocks how the Session handles requests. When used, all requests will route through here
/// Not all my code! The implementation of startLoading was taken from
/// https://medium.com/@dhawaldawar/how-to-mock-urlsession-using-urlprotocol-8b74f389a67a
/// but this seems to be a pretty standard way of intercepting requests for tests at the moment!
class MockURLProtocol: URLProtocol {
  static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?))? = nil
  
  override func startLoading() {
    guard let handler = MockURLProtocol.requestHandler else {
      fatalError("No request handler set")
    }
    
    do {
      // Call handler with received request and capture the tuple of response and data.
      let (response, data) = try handler(request)
      
      // Send received response to the client.
      client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
      
      if let data = data {
        // Send received data to the client.
        client?.urlProtocol(self, didLoad: data)
      }
      
      // Notify request has been finished.
      client?.urlProtocolDidFinishLoading(self)
    } catch {
      // Notify received error.
      client?.urlProtocol(self, didFailWithError: error)
    }
  }
  
  override class func canInit(with request: URLRequest) -> Bool {
    return true
  }
  
  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    return request
  }
  
  override func stopLoading() {
  }
  
  static func set(statusCode: Int, jsonStringData: String) {
    
    let data = jsonStringData.data(using: .utf8)
    
    requestHandler = { request in
      let response = HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
      return (response, data)
    }
  }
  
  static func clearHandlers() {
    requestHandler = nil
  }
}

