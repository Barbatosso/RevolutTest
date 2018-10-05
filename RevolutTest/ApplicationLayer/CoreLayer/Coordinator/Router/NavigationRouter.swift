//
//  NavigationRouter.swift
//  RevolutTest
//
//  Created by Egor Petrov on 05/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit

struct NavigationRouter: Routable {

  private let navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func toPresent() -> UIViewController? {
    return navigationController
  }

  func setRoot(_ module: Presentable?, animated: Bool) {
    guard let controllerToSet = module?.toPresent() else { return }
    navigationController.setViewControllers([controllerToSet], animated: animated)
  }

  func present(_ module: Presentable?, animated: Bool) {
    guard let controllerToPresent = module?.toPresent() else {
      assertionFailure("Cannot to present module: \(module.debugDescription)")
      return
    }
    navigationController.present(controllerToPresent, animated: true, completion: nil)
  }

  func dismissModule(animated: Bool, with completion: (() -> Void)?) {
    navigationController.dismiss(animated: animated, completion: completion)
  }

  func push(_ module: Presentable?, animated: Bool) {
    guard let controllerToPush = module?.toPresent() else {
      assertionFailure("Cannot to push module: \(module.debugDescription)")
      return
    }
    if let topController = navigationController.topViewController,
      type(of: controllerToPush) == type(of: topController) { return }
    navigationController.pushViewController(controllerToPush, animated: animated)
  }

  func popModule(animated: Bool) {
    navigationController.popViewController(animated: animated)
  }
}
