//
//  FundsViewModelInut.swift
//  RevolutTest
//
//  Created by Egor Petrov on 24/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

protocol FundsViewModelInput {

  typealias Handler = ([String: Double]) -> Void
  typealias FundsObsrerver = (observer: AnyObject, handler: Handler)

  var numberOfItems: Int { get }
  var items: Observable<[String: Double]> { get }

  func changeBaseFundCodeTo(_ code: String)
  func startPollingFunds()

  func addFundsOberver(_ observer: FundsObsrerver)
}
