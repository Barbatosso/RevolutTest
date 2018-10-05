//
//  Presentable.swift
//  RevolutTest
//
//  Created by Egor Petrov on 05/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit

protocol Presentable {

  func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {

  func toPresent() -> UIViewController? {
    return self
  }
}
