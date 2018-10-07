//
//  FundsType.swift
//  RevolutTest
//
//  Created by Egor Petrov on 07/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

protocol FundsType {

  var base: String { get }
  var date: Date { get }
  var rates: [String: Double] { get }
}
