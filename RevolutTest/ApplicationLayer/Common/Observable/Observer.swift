//
//  Observer.swift
//  RevolutTest
//
//  Created by Egor Petrov on 22/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

struct Observer<T> {

  typealias Handler = (T) -> Void

  weak var onwer: AnyObject?

  let handler: Handler

  init(owner: AnyObject, handler: @escaping Handler ) {
    self.onwer = owner
    self.handler = handler
  }
}
