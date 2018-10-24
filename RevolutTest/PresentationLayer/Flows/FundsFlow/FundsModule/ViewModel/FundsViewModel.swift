//
//  FundsViewModel.swift
//  RevolutTest
//
//  Created by Egor Petrov on 23/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

protocol FundsViewModel {

  var numberOfItems: Int { get }
  var items: [String: Double] { get }
}
