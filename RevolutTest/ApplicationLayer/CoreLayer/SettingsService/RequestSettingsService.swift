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
  func updateDefaultRequestParameters(with parameter: String)
  func getDefaultRequestParameters() -> String
}

class RequestSettingsServiceImpl: RequestSettingsService {

  private let userDefaults: UserDefaults

  private enum Constants {

    enum Keys {

      static let standartRequestParameterKey = "default_parameters_key"
    }

    enum Values {

      static let standartRequestParameter = "EUR"
    }
  }

  init(userDefaults: UserDefaults) {
    self.userDefaults = userDefaults
  }

  func registerDefaultRequestParameters() {
    guard UserDefaults.standard.value(forKey: Constants.Keys.standartRequestParameterKey) == nil else { return }
    updateDefaultRequestParameters(with: Constants.Values.standartRequestParameter)
  }

  func updateDefaultRequestParameters(with parameter: String) {
    userDefaults.set(parameter, forKey: Constants.Keys.standartRequestParameterKey)
  }

  func getDefaultRequestParameters() -> String {
    guard let parameter = userDefaults.value(forKey: Constants.Keys.standartRequestParameterKey) as? String
      else {
        log.error("Cannot get value for request, return Constant value: \(Constants.Values.standartRequestParameter)")
        updateDefaultRequestParameters(with: Constants.Values.standartRequestParameter)
        return Constants.Values.standartRequestParameter
    }

    return parameter
  }
}
