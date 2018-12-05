//
//  RequestSettingsService.swift
//  RevolutTest
//
//  Created by Egor Petrov on 28/11/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

protocol RequestSettingsService {

  func registerDefaultRequestParameters()
  func updateDefaultRequestParameters(currencyCode: String, value: Double)
  func getDefaultRequestParameters() -> StandartFundsRequestParameters
}

class RequestSettingsServiceImpl: RequestSettingsService {

  private let userDefaults: UserDefaults

  private enum Constants {

    enum Keys {

      static let standartCodeKey = "default_fundsService_currency_code"
      static let standartValueKey = "default_fundsService_value"
    }

    enum Values {

      static let standartValue = StandartFundsRequestParameters(currencyCode: "EUR", value: 1.0)
    }
  }

  init(userDefaults: UserDefaults) {
    self.userDefaults = userDefaults
  }

  func registerDefaultRequestParameters() {
    guard userDefaults.value(forKey: Constants.Keys.standartCodeKey) as? String == nil,
    userDefaults.value(forKey: Constants.Keys.standartValueKey) as? Double == nil
      else { return }
    updateDefaultRequestParameters(
      currencyCode: Constants.Values.standartValue.currencyCode,
      value: Constants.Values.standartValue.value)
  }

  func updateDefaultRequestParameters(currencyCode: String, value: Double) {
    userDefaults.set(currencyCode, forKey: Constants.Keys.standartCodeKey)
    userDefaults.set(value, forKey: Constants.Keys.standartValueKey)
  }

  func getDefaultRequestParameters() -> StandartFundsRequestParameters {
    guard let code = userDefaults.value(forKey: Constants.Keys.standartCodeKey) as? String,
    let value = userDefaults.value(forKey: Constants.Keys.standartValueKey) as? Double
      else {
        log.error("Cannot get value for request, return Constant value: \(Constants.Values.standartValue)")
        updateDefaultRequestParameters(
          currencyCode: Constants.Values.standartValue.currencyCode,
          value: Constants.Values.standartValue.value)
        return Constants.Values.standartValue
    }
    let parameter = StandartFundsRequestParameters(currencyCode: code, value: value)
    return parameter
  }
}
