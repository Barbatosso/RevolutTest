//
//  TestAppRouter.swift
//  RevolutTestTests
//
//  Created by Egor Petrov on 11/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import XCTest

class TestAppRouter: XCTestCase {

  private var window: UIWindow!
  private var router: Routable!
  private var mockModule: MockModule!
  private var navigationRouter: NavigationRouter!

  override func setUp() {
    window = UIWindow()
    router = AppRouter(window: window)
    navigationRouter = NavigationRouter(navigationController: UINavigationController())
    router.setRoot(navigationRouter)
    mockModule = MockViewController()
  }

  override func tearDown() {
    window = nil
    router = nil
    mockModule = nil
    navigationRouter = nil
  }

  func testSetRootCoontroller() {
    XCTAssertNotNil(window.rootViewController)

    router.setRoot(navigationRouter, animated: true)

    XCTAssertTrue(router.toPresent() === navigationRouter.toPresent())
  }

  func testPresentAndDismissModule() {
    let viewControllers = (window.rootViewController as? UINavigationController)?.viewControllers
    XCTAssertTrue(viewControllers?.isEmpty == true, "ViewControllers must be empty before test")

    router.present(mockModule)

    XCTAssertFalse(viewControllers?.isEmpty == false)

    router.dismissModule()

    XCTAssertTrue(viewControllers?.isEmpty == true)
  }

  func testPushAndPopModule() {
    var viewControllers = (window.rootViewController as? UINavigationController)?.viewControllers
    viewControllers?.removeAll()

    router.push(mockModule)

    XCTAssertFalse(viewControllers?.isEmpty == false)

    router.popModule()

    XCTAssertTrue(viewControllers?.isEmpty == true)
  }
}
