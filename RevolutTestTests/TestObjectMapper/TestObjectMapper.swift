//
//  TestObjectMapper.swift
//  RevolutTestTests
//
//  Created by Egor Petrov on 10/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import XCTest

class TestObjectMapper: XCTestCase {

  private var mapper: Mapper!
  private var stubFunds: StubFunds!
  private var encodedData: Data!

  override func setUp() {
    mapper = JsonObjectMapper()
    stubFunds = StubFunds()
    encodedData = try? JSONEncoder().encode(stubFunds)
  }

  override func tearDown() {
    mapper = nil
  }

  func testObjectDecoder() {
    XCTAssertNotNil(encodedData, "Stub data has been wrong encoded")

    log.verbose([String(data: encodedData!, encoding: .utf8)])

    var result: Funds?
    do {
      result = try mapper?.result(from: encodedData!)
    } catch {
      log.error(error)
      XCTAssertThrowsError(error)
    }

    XCTAssertNotNil(result)
  }

  func testPerformanceExample() {
    measure {
      testObjectDecoder()
    }
  }
}
