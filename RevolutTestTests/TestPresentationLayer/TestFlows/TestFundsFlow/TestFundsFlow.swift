//
//  TestFundsFlow.swift
//  RevolutTestTests
//
//  Created by Egor Petrov on 12/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import XCTest

class TestFundsFlow: XCTestCase {

  private var fundsCoordinator: FundsCoordinator!
  private var navigationController: UINavigationController!

  override func setUp() {
    let appRouter = AppRouter(window: UIWindow())
    navigationController = UINavigationController()
    let navigationRouter = NavigationRouter(navigationController: navigationController)
    appRouter.setRoot(navigationRouter)
    fundsCoordinator = FundsCoordinatorImpl(router: navigationRouter)
  }

  override func tearDown() {
    fundsCoordinator = nil
    navigationController = nil
  }

  func testStartFundsCoordinator() {
    fundsCoordinator.start()

    XCTAssertFalse(navigationController.viewControllers.isEmpty)
  }
}
