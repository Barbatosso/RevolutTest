//
//  Coordinator.swift
//  RevolutTest
//
//  Created by Egor Petrov on 05/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

protocol Coordinator: class {

  var childCoordinators: [Coordinator] { get }

  var router: Routable { get }

  func start()
}
