//
//  AppRouter.swift
//  RevolutTest
//
//  Created by Egor Petrov on 05/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit

class AppRouter: NSObject, Routable {

  private weak var window: UIWindow?
  private var rootContoller: UIViewController? {
    get {
      return window?.rootViewController
    }
    set {
      rootContoller?.dismiss(animated: false, completion: nil)
      window?.rootViewController = newValue
    }
  }

  init(window: UIWindow?) {
    self.window = window
  }

  func toPresent() -> UIViewController? {
    return rootContoller
  }

  func setRoot(_ module: Presentable?, animated: Bool) {
    guard let toController = module?.toPresent() else {
      assertionFailure("Cannot to set root module: \(module.debugDescription)")
      return
    }
    guard let fromController = rootContoller,
              animated,
              let snapshot = fromController.view.snapshotView(afterScreenUpdates: true) else {
      rootContoller = toController
      return
    }
    toController.view.addSubview(snapshot)
    rootContoller = toController
    UIView.animate(withDuration: 1, animations: {
      snapshot.alpha = 0.8
      snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
    }, completion: { _ in
      snapshot.removeFromSuperview()
    })
  }

  func present(_ module: Presentable?, animated: Bool) {
    guard let controllerToPresent = module?.toPresent() else {
      assertionFailure("Cannot to present module: \(module.debugDescription)")
      return
    }
    rootContoller?.present(controllerToPresent, animated: animated, completion: nil)
  }

  func dismissModule(animated: Bool, with completionHandler: CompletionHandler?) {
    rootContoller?.dismiss(animated: animated, completion: completionHandler)
  }

  func push(_ module: Presentable?, animated: Bool) {
    guard let controllerToPresent = module?.toPresent() else {
      assertionFailure("Cannot to push module: \(module.debugDescription)")
      return
    }
    guard let navigationController = rootContoller as? UINavigationController else {
      assertionFailure("Your can't push module because your rootController is: \(rootContoller.debugDescription)")
      return
    }
    navigationController.pushViewController(controllerToPresent, animated: animated)
  }

  func popModule(animated: Bool) {
    guard let navigationController = rootContoller as? UINavigationController else {
      assertionFailure("Your can't pop module because your rootController is: \(rootContoller.debugDescription)")
      return
    }
    navigationController.popViewController(animated: animated)
  }
}
