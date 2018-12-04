//
//  FundsCoordinator.swift
//  RevolutTest
//
//  Created by Egor Petrov on 09/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

protocol FundsCoordinator: Coordinator { }

class FundsCoordinatorImpl: BaseCoordinator, FundsCoordinator {

  override func start() {
    showFundsModule()
  }

  private func showFundsModule() {
    let assembly = FundsModuleFabric()

    let module = assembly.assemble()
    router.setRoot(module)
  }
}
