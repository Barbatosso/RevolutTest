//
//  TestBaseCoordintator.swift
//  RevolutTestTests
//
//  Created by Egor Petrov on 11/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import XCTest

class TestBaseCoordintator: XCTestCase {

  private var navigationRouter: NavigationRouter!
  private var baseCoordinator: BaseCoordinator!
  private var fundsCoordinator: FundsCoordinator!

  override func setUp() {
    navigationRouter = NavigationRouter(navigationController: UINavigationController())
    baseCoordinator = BaseCoordinator(router: navigationRouter)
    fundsCoordinator = FundsCoordinatorImpl(router: navigationRouter)
  }

  override func tearDown() {
    navigationRouter = nil
    baseCoordinator = nil
    fundsCoordinator = nil
  }

  func testAddAndRemoveDependency() {
    baseCoordinator.addDependency(fundsCoordinator)

    XCTAssertFalse(baseCoordinator.childCoordinators.isEmpty)

    baseCoordinator.removeDependency(fundsCoordinator)

    XCTAssertTrue(baseCoordinator.childCoordinators.isEmpty)
  }

  func testRemoveAllDependencies() {
    XCTAssertTrue(baseCoordinator.childCoordinators.isEmpty, "Child coordinators must be empty before test")

    baseCoordinator.addDependency(fundsCoordinator)

    XCTAssertFalse(baseCoordinator.childCoordinators.isEmpty)

    baseCoordinator.removeAllDependencies()

    XCTAssertTrue(baseCoordinator.childCoordinators.isEmpty)
  }
}
