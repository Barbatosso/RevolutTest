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
  func updateDefaultRequestParameters(with parameter: StandartFundsRequestParameters)
  func getDefaultRequestParameters() -> StandartFundsRequestParameters
}

class RequestSettingsServiceImpl: RequestSettingsService {

  private let userDefaults: UserDefaults

  private enum Constants {

    enum Keys {

      static let standartFundsServiceParametersKey = "default_fundsService_parameters"
    }

    enum Values {

      static let standartValue = StandartFundsRequestParameters(currencyCode: "EUR", value: 1)
    }
  }

  init(userDefaults: UserDefaults) {
    self.userDefaults = userDefaults
  }

  func registerDefaultRequestParameters() {
    guard UserDefaults.standard.value(
      forKey: Constants.Keys.standartFundsServiceParametersKey
      ) as? StandartFundsRequestParameters == nil
      else { return }
    updateDefaultRequestParameters(with: Constants.Values.standartValue)
  }

  func updateDefaultRequestParameters(with parameter: StandartFundsRequestParameters) {
    userDefaults.set(parameter, forKey: Constants.Keys.standartFundsServiceParametersKey)
  }

  func getDefaultRequestParameters() -> StandartFundsRequestParameters {
    guard let parameter = userDefaults.value(
      forKey: Constants.Keys.standartFundsServiceParametersKey
      ) as? StandartFundsRequestParameters
      else {
        log.error("Cannot get value for request, return Constant value: \(Constants.Values.standartValue)")
        updateDefaultRequestParameters(with: Constants.Values.standartValue)
        return Constants.Values.standartValue
    }

    return parameter
  }
}
