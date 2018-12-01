//
//  FundsPollingService.swift
//  RevolutTest
//
//  Created by Egor Petrov on 01/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

class FundsPollingService: PollingService {

  typealias Result = Funds

  private let fundsService: FundsService
  private let configService: Configurator

  private var currencyCode = ""

  private var timer: Timer?

  var onValueUpdate: UpdateValueHandler?

  init(fundsService: FundsService, configService: Configurator) {
    self.fundsService = fundsService
    self.configService = configService

    timer = configureTimer(with: configService.pollServiceDebounce)
  }

  func updateRequstParameter(with newParameter: String) {
    currencyCode = newParameter
  }

  private func configureTimer(with delay: Double) -> Timer {
    return Timer(
      timeInterval: delay,
      target: self,
      selector: #selector(obtainCurrencies),
      userInfo: nil,
      repeats: true)
  }

  func startPollingWith(parameter: String) {
    if timer == nil {
      timer = configureTimer(with: configService.pollServiceDebounce)
    }
    currencyCode = parameter
    RunLoop.current.add(timer!, forMode: .common)
    timer?.fire()
  }

  func stopPolling() {
    timer?.invalidate()
  }

  @objc private func obtainCurrencies() {
    guard let valueUpdater = onValueUpdate else {
      assertionFailure("OnUpdateValue(result:error) isn't configured: \(onValueUpdate.debugDescription)")
      return
    }
    fundsService.fetchFunds(for: currencyCode, with: valueUpdater)
  }
}
