//
//  Observable.swift
//  RevolutTest
//
//  Created by Egor Petrov on 22/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

class Observable<T> {

  var value: T

  private lazy var observers = [Observer<T>]()

  init(value: T) {
    self.value = value
  }

  func observe(_ observer: AnyObject, handler: @escaping (T) -> Void) {
    cleanDeadObservers()
    observers.append(Observer(owner: observer, handler: handler))
  }

  private func cleanDeadObservers() {
    observers.removeAll { $0.onwer == nil }
  }
}
