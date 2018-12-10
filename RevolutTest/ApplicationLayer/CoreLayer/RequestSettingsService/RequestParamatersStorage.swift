//
//  RequestParamatersStorage.swift
//  RevolutTest
//
//  Created by Egor Petrov on 28/11/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

protocol RequestParamatersStorage {

  func registerDefaultRequestParameters()
  func updateDefaultRequestParameters(currencyCode: String)
  func getDefaultRequestParameters() -> StandartFundsRequestParameters
}

class RequestParametersStorageImpl: RequestParamatersStorage {

  private let userDefaults: UserDefaults

  private enum Constants {

    enum Keys {

      static let standartCodeKey = "default_fundsService_currency_code"
      static let standartValueKey = "default_fundsService_value"
    }

    enum Values {

      static let standardCurrency = "EUR"
      static let standardValue = 1.0
    }
  }

  init(userDefaults: UserDefaults) {
    self.userDefaults = userDefaults
  }

  func registerDefaultRequestParameters() {
    guard userDefaults.value(forKey: Constants.Keys.standartCodeKey) as? String == nil,
    userDefaults.value(forKey: Constants.Keys.standartValueKey) as? Double == nil
      else { return }
    updateDefaultRequestParameters(currencyCode: Constants.Values.standardCurrency)
  }

  func updateDefaultRequestParameters(currencyCode: String) {
    userDefaults.set(currencyCode, forKey: Constants.Keys.standartCodeKey)
    userDefaults.set(Constants.Values.standardValue, forKey: Constants.Keys.standartValueKey)
  }

  func getDefaultRequestParameters() -> StandartFundsRequestParameters {
    guard let code = userDefaults.value(forKey: Constants.Keys.standartCodeKey) as? String,
    let value = userDefaults.value(forKey: Constants.Keys.standartValueKey) as? Double
      else {
        let standardParameters = StandartFundsRequestParameters(
          currencyCode: Constants.Values.standardCurrency,
          value: Constants.Values.standardValue
        )
        log.error("Cannot get value for request, return Constant value: \(standardParameters)")
        updateDefaultRequestParameters(currencyCode: Constants.Values.standardCurrency)
        return standardParameters
    }
    let parameter = StandartFundsRequestParameters(currencyCode: code, value: value)
    return parameter
  }
}
