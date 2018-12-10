//
//  TestApiTarget.swift
//  TestApiTarget
//
//  Created by Egor Petrov on 29/11/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import XCTest

class TestApiTarget: XCTestCase {

  private var apiTarget = FundsServiceTarget.funds(base: "EUR")

  func testHTTPMethod() {
    XCTAssertTrue(apiTarget.method == .get, "Funds service target method must be .get")
  }

  func testHTTPParamaters() {
    XCTAssertNotNil(apiTarget.parameters, "Funds service target parameters shouldn't be nil")
  }
}
