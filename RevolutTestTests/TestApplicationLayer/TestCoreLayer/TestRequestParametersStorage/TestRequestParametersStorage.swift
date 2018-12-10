//
//  TestRequestParametersStorage.swift
//  RevolutTestTests
//
//  Created by Egor Petrov on 10/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import XCTest

class TestRequestParametersStorage: XCTestCase {

  private var storage: TestableParametersStorage!

  private enum Constants {

    static let standardCurrency = "THB"
  }

  override func setUp() {
    super.setUp()
    storage = RequestParametersStorageImpl(userDefaults: UserDefaults.standard)
  }

  override func tearDown() {
    super.setUp()
    storage = nil
  }

  func testRegisteringStandardValue() {
    storage.removeAllParameters()
    storage.registerDefaultRequestParameters()

    let parameters = storage.getDefaultRequestParameters()

    XCTAssertTrue(parameters.currencyCode == "EUR" && parameters.value == 1.0,
                  "Default parameters must be EUR with ratio = 1, now it's \(parameters.currencyCode) with \(parameters.value) ratio")
  }

  func testUpdateDefaultStandardCurrency() {
    storage.updateDefaultRequestParameters(currencyCode: Constants.standardCurrency)

    var parameters = storage.getDefaultRequestParameters()

    XCTAssertTrue(parameters.currencyCode == Constants.standardCurrency && parameters.value == 1.0,
                  "Updated value must be THB")

    storage.registerDefaultRequestParameters()

    parameters = storage.getDefaultRequestParameters()

    XCTAssertTrue(parameters.currencyCode == Constants.standardCurrency && parameters.value == 1.0,
                  "Secondary registering default values")
  }
}
