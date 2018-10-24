//
//  FundsViewModel.swift
//  RevolutTest
//
//  Created by Egor Petrov on 23/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

class FundsViewModel: FundsViewModelInput {

  var fundsService: FundsService

  var numberOfItems: Int {
    return items.value.count
  }

  var items: Observable<[String: Double]>

  private var timer: Timer?
  private let fundCode = Observable<String>(value: "EUR")

  init(fundsService: FundsService) {
    self.fundsService = fundsService

    items = Observable<[String: Double]>(value: [:])
  }

  func startPollingFunds() {
    timer = Timer(timeInterval: 1.0, repeats: true) { [weak self] _ in
      guard let strongSelf = self else { return }
      strongSelf.fundsService.fetchFunds(for: strongSelf.fundCode.value) { funds, error in
      }
    }
  }

  func changeBaseFundCodeTo(_ code: String) {
    fundCode.value = code
  }

  func addFundsOberver(_ observer: FundsObsrerver) {
    items.observe(observer.observer, handler: observer.handler)
  }
}
