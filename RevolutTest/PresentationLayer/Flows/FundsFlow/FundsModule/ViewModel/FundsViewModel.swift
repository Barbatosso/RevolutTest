//
//  FundsViewModel.swift
//  RevolutTest
//
//  Created by Egor Petrov on 02/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

protocol FundsViewModel: class {

  var standartRowData: FundsItem { get }
  func getFunds(with handler: @escaping (FundsType?, Error?) -> Void)

  func addFundsObserver(for observer: AnyObject, with handler: @escaping (FundsType?) -> Void)

  func viewIsReady(_ isReady: Bool)
}

class FundsViewModelImpl: FundsViewModel {

  private let funds: Observable<FundsType> = Observable<FundsType>(value: nil)
  private var viewIsReady = false {
    didSet {
      if viewIsReady {
        setupPollSevicehandler()
      }
    }
  }

  var settingsService: RequestSettingsService
  var fundsPollingService: FundsPollingService

  var standartRowData: FundsItem {
    let parameters = settingsService.getDefaultRequestParameters()
    return FundsItem.init(fundsCode: parameters.currencyCode, value: parameters.value)
  }

  init(settingsService: RequestSettingsService, fundsPollingService: FundsPollingService) {
    self.settingsService = settingsService
    self.fundsPollingService = fundsPollingService
  }

  func getFunds(with handler: @escaping (FundsType?, Error?) -> Void) {
    fundsPollingService.onValueUpdate = handler
    fundsPollingService.startPollingWith(parameter: settingsService.getDefaultRequestParameters().currencyCode)
  }

  func addFundsObserver(for observer: AnyObject, with handler: @escaping (FundsType?) -> Void) {
    funds.observe(observer, handler: handler)
  }

  func viewIsReady(_ isReady: Bool) {
    viewIsReady = isReady
  }

  private func setupPollSevicehandler() {
    fundsPollingService.onValueUpdate = { [weak funds] fundsItem, _ in
      funds?.value = fundsItem
    }
  }
}
