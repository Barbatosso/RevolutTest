//
//  Funds.swift
//  RevolutTest
//
//  Created by Egor Petrov on 07/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

struct Funds: FundsType, Decodable {

  var base: String
  var date: Date
  var rates: [String: Double]
}
