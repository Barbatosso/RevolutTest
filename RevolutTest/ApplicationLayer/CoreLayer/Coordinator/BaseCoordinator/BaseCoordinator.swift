//
//  BaseCoordinator.swift
//  RevolutTest
//
//  Created by Egor Petrov on 05/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

class BaseCoordinator: Coordinator {

  var childCoordinators: [Coordinator] = []

  var router: Routable

  init(router: Routable) {
    self.router = router
  }

  func start() { assertionFailure("You need to provide your own coordinator implementation") }

  func addDependency(_ coordinator: Coordinator) {
    for element in childCoordinators where element === coordinator {
      return
    }
    childCoordinators.append(coordinator)
  }

  func removeDependency(_ coordinator: Coordinator?) {
    guard !childCoordinators.isEmpty,
          let coordinator = coordinator
    else { return }

    for (index, element) in childCoordinators.enumerated() where element === coordinator {
      childCoordinators.remove(at: index)
      break
    }
  }

  func removeAllDependencies() {
    childCoordinators.removeAll()
  }
}
