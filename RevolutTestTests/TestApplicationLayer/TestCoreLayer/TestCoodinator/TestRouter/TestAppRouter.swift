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
  private var navigationController: UINavigationController!
  private var router: Routable!
  private var mockModule: MockModule!
  private var navigationRouter: NavigationRouter!

  override func setUp() {
    window = UIWindow(frame: UIScreen.main.bounds)
    navigationController = UINavigationController()
    router = AppRouter(window: window)
    navigationRouter = NavigationRouter(navigationController: navigationController)
    router.setRoot(navigationRouter)
    mockModule = MockViewController()
  }

  override func tearDown() {
    window = nil
    router = nil
    navigationController = nil
    mockModule = nil
    navigationRouter = nil
  }

  func testSetRootCoontroller() {
    XCTAssertNotNil(window.rootViewController)

    router.setRoot(navigationRouter, animated: true)

    XCTAssertTrue(router.toPresent() === navigationRouter.toPresent())
  }

  func testPresentAndDismissModuleInAppRouter() {
    let viewControllers = navigationController.viewControllers
    XCTAssertTrue(viewControllers.isEmpty, "ViewControllers must be empty before test")

    router.present(mockModule)

    XCTAssertFalse(viewControllers.isEmpty == false)

    router.dismissModule()

    XCTAssertTrue(viewControllers.isEmpty == true)
  }

  func testSetRootModule() {
    XCTAssertTrue(navigationController.viewControllers.isEmpty,
                  "ViewControllers must be empty before setRootModule")

    navigationRouter.setRoot(mockModule)

    XCTAssertFalse(navigationController.viewControllers.isEmpty)
  }

  func testPushAndPopModule() {
    navigationController.viewControllers.removeAll()
    XCTAssertTrue(navigationController.viewControllers.isEmpty,
                  "ViewControllers must be empty before push and pop")

    navigationRouter.push(mockModule)

    XCTAssertFalse(navigationController.viewControllers.isEmpty)

    navigationRouter.popModule()

    XCTAssertTrue(navigationController.viewControllers.isEmpty)
  }

  func testPresentAndDismissModule() {
    navigationController.viewControllers.removeAll()
    XCTAssertTrue(navigationController.viewControllers.isEmpty,
                  "ViewControllers must be empty before present and dismiss")

    navigationRouter.present(mockModule)

    XCTAssertFalse(navigationController.viewControllers.isEmpty)

    navigationRouter.dismissModule()

    XCTAssertTrue(navigationController.viewControllers.isEmpty)
  }
}
