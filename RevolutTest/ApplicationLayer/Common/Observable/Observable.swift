//
//  Observable.swift
//  RevolutTest
//
//  Created by Egor Petrov on 22/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

class Observable<T> {

  typealias Handler = (T?) -> Void

  var value: T? {
    didSet {
      observers.forEach {
        $0.handler(value)
      }
    }
  }

  lazy var observers = [Observer<T>]()

  init(value: T?) {
    self.value = value
  }

  func observe(_ observer: AnyObject, handler: @escaping Handler) {
    cleanDeadObservers()
    removeObserver(observer)
    observers.append(Observer(owner: observer, handler: handler))
  }

  func setObservers(from observable: Observable<T>) {
    observers = observable.observers
  }

  func observeWithUniqueObserver(_ observer: AnyObject, handler: @escaping Handler) {
    cleanAllObservers()
    observers.append(Observer(owner: observer, handler: handler))
  }

  private func cleanDeadObservers() {
    observers.removeAll { $0.onwer == nil }
  }

  func cleanAllObservers() {
    observers.removeAll()
  }

  private func removeObserver(_ observer: AnyObject) {
    observers.removeAll { $0.onwer === observer }
  }
}
