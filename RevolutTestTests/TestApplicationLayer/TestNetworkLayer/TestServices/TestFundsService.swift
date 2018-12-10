//
//  TestFundsService.swift
//  RevolutTestTests
//
//  Created by Egor Petrov on 11/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import XCTest

class TestFundsService: XCTestCase {

  private var fundsService: FundsService!

  override func setUp() {
    super.setUp()

    let jsonMapper = JsonObjectMapper()
    let config = ConfigService()
    let apiService = ApiService(configService: config, mapper: jsonMapper)
    fundsService = FundsServiceImpl(apiService: apiService)
  }

  override func tearDown() {
    super.tearDown()

    fundsService = nil
  }

  func testFundsRequest() {
    var queryResult: FundsType?
    var queryError: Error?

    let promise = expectation(description: "Started funds fetching")
    fundsService.fetchFunds(for: "EUR") { funds, error in
      queryError = error
      queryResult = funds

      promise.fulfill()
    }

    waitForExpectations(timeout: 5.0, handler: nil)
    XCTAssertNotNil(queryResult)
    XCTAssertNil(queryError)
  }
}
