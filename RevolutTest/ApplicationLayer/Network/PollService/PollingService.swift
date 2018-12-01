//
//  PollingService.swift
//  RevolutTest
//
//  Created by Egor Petrov on 28/11/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

protocol PollingService {

  associatedtype Result: Decodable

  var onValueUpdate: ((Result) -> Void) { get set }

  func startPollingWith(parameter: String)

  func stopPolling()

  func updateRequstParameter(with newParameter: String)
}

class FundsPollingServiceImpl: PollingService {

  private let fundsService: FundsService

  private var currencyCode = ""

  private var timer: Timer?

  init(fundsService: FundsService, configService: Configurator) {
    self.fundsService = fundsService
    timer = configureTimer(with: configService.pollServiceDebounce)
  }

  func configureTimer(with delay: Double) -> Timer {
    return Timer(
      timeInterval: delay,
      target: self,
      selector: #selector(obtainCurrencies),
      userInfo: currencyCode,
      repeats: true)
  }

  func startPollingWith(parameter: String) throws {
    guard let timer = timer else {
      throw PollServiceError.timerIsNotConfigured
      return
    }
    currencyCode = parameter
    RunLoop.current.add(timer, forMode: .common)
    timer.fire()
  }

  func stopPolling() {
  }

  @objc private func obtainCurrencies(with timer: Timer) {
    
  }
}
