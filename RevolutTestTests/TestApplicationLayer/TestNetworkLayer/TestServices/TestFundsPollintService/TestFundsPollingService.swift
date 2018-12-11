//
//  TestFundsPollingService.swift
//  RevolutTestTests
//
//  Created by Egor Petrov on 11/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import XCTest

class TestFundsPollingService: XCTestCase {

  private var fundsPollingService: FundsPollingService!
  private var error: Error?
  private var funds: [Funds?] = []

  private let observingPromise: XCTestExpectation = {
    let promise = XCTestExpectation(description: "Start observing polls")
    promise.expectedFulfillmentCount = 2
    return promise
  }()

  private let updateValuePromise: XCTestExpectation = {
    let promise = XCTestExpectation(description: "Update value polls")
    promise.expectedFulfillmentCount = 2
    return promise
  }()

  override func setUp() {
    super.setUp()

    let mapper = JsonObjectMapper()
    let configService = ConfigService()
    let apiService = ApiService(configService: configService, mapper: mapper)
    let fundsService = FundsServiceImpl(apiService: apiService)
    fundsPollingService = FundsPollingService(fundsService: fundsService, configService: configService)
    fundsPollingService.onValueUpdate = { [weak self] in
      self?.error = $1
      self?.funds.append($0)

      if $0?.base == "CZK" {
        self?.updateValuePromise.fulfill()
      } else {
        self?.observingPromise.fulfill()
      }
    }
  }

  override func tearDown() {
    super.tearDown()

    fundsPollingService = nil
  }

  func testStartPolling() {

    fundsPollingService.startPollingWith(parameter: "EUR")

    wait(for: [observingPromise], timeout: 10)

    XCTAssertFalse(funds.isEmpty)
    funds.forEach {
      XCTAssertTrue($0?.base == "EUR")
    }
    XCTAssertNil(error)
  }

  func testUpdateRequestParameter() {
    fundsPollingService.startPollingWith(parameter: "EUR")

    wait(for: [observingPromise], timeout: 5)

    fundsPollingService.updateRequstParameter(with: "CZK")

    wait(for: [updateValuePromise], timeout: 5)

    XCTAssertFalse(funds.isEmpty)
    XCTAssertTrue(funds.first!?.base == "EUR" && funds.last!?.base == "CZK")
    XCTAssertNil(error)
  }
}
