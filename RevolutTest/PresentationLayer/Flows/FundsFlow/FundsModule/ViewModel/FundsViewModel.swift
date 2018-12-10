//
//  FundsViewModel.swift
//  RevolutTest
//
//  Created by Egor Petrov on 02/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

typealias Currencies = (funds: FundsType?, value: Double?)

protocol FundsViewModel: class {

  var funds: Observable<Currencies> { get }

  var standartRowData: FundsItem { get }
  func getFunds(with handler: @escaping (FundsType?, Error?) -> Void)
  func updateCurrencyCode(_ currencyCode: String)

  func addFundsObserver(for observer: AnyObject, with handler: @escaping (FundsType?) -> Void)

  func viewIsReady(_ isReady: Bool)

  func observeRatio(_ string: String?)
}

class FundsViewModelImpl: FundsViewModel {

  var funds: Observable<Currencies> = Observable<Currencies>(value: Currencies(funds: nil, value: nil))

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

  func updateCurrencyCode(_ currencyCode: String) {
    fundsPollingService.updateRequstParameter(with: currencyCode)
  }

  func addFundsObserver(for observer: AnyObject, with handler: @escaping (FundsType?) -> Void) {
    funds.observe(observer) { value in
      handler(value?.funds)
    }
  }

  func observeRatio(_ string: String?) {
    guard let text = string, !text.isEmpty, let value = Double(text) else { return }
    funds.value?.value = value
  }

  func viewIsReady(_ isReady: Bool) {
    viewIsReady = isReady
  }

  private func setupPollSevicehandler() {
    fundsPollingService.onValueUpdate = { [weak funds] fundsItem, _ in
      funds?.value?.0 = fundsItem
    }
  }
}
