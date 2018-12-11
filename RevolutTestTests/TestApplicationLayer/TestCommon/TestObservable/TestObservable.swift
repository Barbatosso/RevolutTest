//
//  TestObservable.swift
//  RevolutTestTests
//
//  Created by Egor Petrov on 11/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import XCTest

class TestObservable: XCTestCase {

  private var observable: Observable<String>!

  private var result: [String?] = []

  private var viewHandler: UIView?

  override func setUp() {
    super.setUp()

    observable = Observable<String>(value: nil)
    observable.observe(self) { [weak self] in self?.result.append($0) }

    viewHandler = UIView()
  }

  override func tearDown() {
    super.tearDown()

    observable = nil
    viewHandler = nil
    result.removeAll()
  }

  func testObservingNewValue() {
    observable.value = "Hello"

    XCTAssertFalse(result.isEmpty)
    XCTAssertTrue(result.first == "Hello")
  }

  func testRemovingObservers() {
    observable.cleanAllObservers()

    observable.value = "World"

    XCTAssertFalse(result.count == 2)
  }

  func testAddObserver() {
    XCTAssertNotNil(viewHandler, "View must be not nil")

    observable.observe(viewHandler!) { [weak self] in self?.result.append($0) }

    observable.value = "World"

    XCTAssertTrue(result.count == 2)
    XCTAssertTrue(result.last == "World")
  }

  func testRemoveDeadObserver() {
    viewHandler = nil

    observable.value = "It"

    XCTAssertFalse(result.count == 4)
  }

  func testObserveWithUniqueObserver() {
    if viewHandler == nil {
      viewHandler = UIView()
    }

    result.removeAll()

    observable.observeWithUniqueObserver(viewHandler!) { [weak self] in self?.result.append($0) }

    observable.value = "Unique"

    XCTAssertTrue(result.count == 1)
    XCTAssertTrue(result.first == "Unique")
  }
}
