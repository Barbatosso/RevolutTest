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

  func getFunds()

  func addFundsObserver(for observer: AnyObject, with handler: @escaping (FundsType?) -> Void)

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

  weak var output: FundsViewModelOutput?

  var standardRowData: FundsItem {
    let parameters = settingsService.getDefaultRequestParameters()
    return FundsItem.init(fundsCode: parameters.currencyCode, value: parameters.value)
  }

  init(settingsService: RequestParamatersStorage, fundsPollingService: FundsPollingService) {
    self.settingsService = settingsService
    self.fundsPollingService = fundsPollingService
  }

  func getFunds() {
    fundsPollingService.onValueUpdate = { [weak self] items, _ in
        guard let items = items else { return }
        self?.setupRows(with: items)
    }
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

  func setupRows(with funds: FundsType) {
    var rows = funds.rates.map { [unowned self] item -> FundsTableRow in
      let rowItem = FundsItem(fundsCode: item.key, value: item.value)
      let row = FundsTableRow(
        data: rowItem,
        funds: self.funds
      )
      configureRowTap(for: row, with: item.key)
      return row
    }
    let rowItem = standardRowData
    let row = FundsTableRow(
      data: rowItem,
      funds: self.funds
    )
    self.configureRowTap(for: row, with: rowItem.fundsCode)
    rows.insert(row, at: rows.startIndex)
    output?.setupTableView(with: rows)
  }

  func configureRowTap(for row: FundsTableRow, with key: String) {
    row.onTap = { [weak self] in
      guard let self = self else { return true}
      row.observableText?.observeWithUniqueObserver(self) {
        self.observeRatio($0)
      }
      self.updateCurrencyCode(key)
      return true
    }
  }
}
