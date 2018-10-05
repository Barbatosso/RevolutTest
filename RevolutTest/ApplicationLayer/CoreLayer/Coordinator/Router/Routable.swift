//
//  Routable.swift
//  RevolutTest
//
//  Created by Egor Petrov on 05/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

protocol Routable: Presentable {

  typealias CompletionHandler = () -> Void

  func present(_ module: Presentable?)
  func present(_ module: Presentable?, animated: Bool)

  func dismissModule()
  func dismissModule(animated: Bool, with completionHandler: CompletionHandler?)

  func push(_ module: Presentable?)
  func push(_ module: Presentable?, animated: Bool)

  func popModule()
  func popModule(animated: Bool)

  func setRoot(_ module: Presentable?)
  func setRoot(_ module: Presentable?, animated: Bool)
}

extension Routable {

  func present(_ module: Presentable?) {
    present(module, animated: true)
  }

  func dismissModule() {
    dismissModule(animated: true, with: nil)
  }

  func push(_ module: Presentable?) {
    push(module, animated: true)
  }

  func popModule() {
    popModule(animated: true)
  }

  func setRoot(_ module: Presentable?) {
    setRoot(module, animated: true)
  }
}
