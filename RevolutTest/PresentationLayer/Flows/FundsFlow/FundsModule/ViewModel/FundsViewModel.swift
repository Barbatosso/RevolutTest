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
  var standardRowData: FundsItem { get }

  func getFunds(with handler: @escaping (FundsType?, Error?) -> Void)
  func updateCurrencyCode(_ currencyCode: String)

  func addFundsObserver(for observer: AnyObject, with handler: @escaping (FundsType?) -> Void)
  func observeRatio(_ string: String?)

  func viewIsReady(_ isReady: Bool)

}

class FundsViewModelImpl: FundsViewModel {

  var funds: Observable<Currencies> = Observable<Currencies>(value: Currencies(funds: nil, value: nil))

  private var viewIsReady = false {
    didSet {
      if viewIsReady {
        setupPollServiceHandler()
      }
    }
  }

  var settingsService: RequestParamatersStorage
  var fundsPollingService: FundsPollingService

  var standardRowData: FundsItem {
    let parameters = settingsService.getDefaultRequestParameters()
    return FundsItem.init(fundsCode: parameters.currencyCode, value: parameters.value)
  }

  init(settingsService: RequestParamatersStorage, fundsPollingService: FundsPollingService) {
    self.settingsService = settingsService
    self.fundsPollingService = fundsPollingService
  }

  func getFunds(with handler: @escaping (FundsType?, Error?) -> Void) {
    fundsPollingService.onValueUpdate = handler
    fundsPollingService.startPollingWith(parameter: settingsService.getDefaultRequestParameters().currencyCode)
  }

  func updateCurrencyCode(_ currencyCode: String) {
    fundsPollingService.updateRequstParameter(with: currencyCode)
    settingsService.updateDefaultRequestParameters(currencyCode: currencyCode)
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

  private func setupPollServiceHandler() {
    fundsPollingService.onValueUpdate = { [weak funds] fundsItem, _ in
      funds?.value?.funds = fundsItem
    }
  }
}
