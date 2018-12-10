//
//  TestConfigService.swift
//  RevolutTestTests
//
//  Created by Egor Petrov on 10/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import XCTest

class TestConfigService: XCTestCase {

  private let stubUrl = URL(string: "https://revolut.duckdns.org")

  private var configService: Configurator?

  override func setUp() {
    super.setUp()
    configService = ConfigService()
  }

  override func tearDown() {
    super.tearDown()
    configService = nil
  }

  func testApiUrl() {
    let apiUrl = configService?.apiUrl
    XCTAssertTrue(apiUrl == stubUrl, "Api url has been changed")
  }

  func testPollServiceDebounce() {
    XCTAssertTrue(configService?.pollServiceDebounce == 1.0, "Poll service debounce isn't equal")
  }
}
