//
//  TestApiService.swift
//  RevolutTestTests
//
//  Created by Egor Petrov on 10/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import XCTest

class TestApiService: XCTestCase {

  private var apiService: ApiRequester!

  override func setUp() {
    super.setUp()

    let mapper = JsonObjectMapper()
    let config = MockConfigService()

    apiService = ApiService(configService: config, mapper: mapper)
  }

  override func tearDown() {
    super.tearDown()

    apiService = nil
  }

  func testMockRequest() {
    var queryResult: MockTemplateEntity?
    var queryError: Error?

    let promise = expectation(description: "Query started")

    apiService.runRequest(for: MockApiTarget.getMockData) { (result: MockTemplateEntity?, error) in
      queryError = error
      queryResult = result
      promise.fulfill()
    }

    waitForExpectations(timeout: 50.0, handler: nil)

    XCTAssertNotNil(queryResult)
    XCTAssertNil(queryError)
  }
}
