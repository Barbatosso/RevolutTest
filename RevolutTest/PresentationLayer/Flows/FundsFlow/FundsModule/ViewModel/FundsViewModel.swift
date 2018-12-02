//
//  FundsViewModel.swift
//  RevolutTest
//
//  Created by Egor Petrov on 02/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

protocol FundsViewModel {

  func getFunds(with handler: @escaping (FundsType?, Error?) -> Void)
}

class FundsViewModelImpl: FundsViewModel {

  var settingsService: RequestSettingsService
  var fundsPollingService: FundsPollingService

  init(settingsService: RequestSettingsService, fundsPollingService: FundsPollingService) {
    self.settingsService = settingsService
    self.fundsPollingService = fundsPollingService
  }

  func getFunds(with handler: @escaping (FundsType?, Error?) -> Void) {
    fundsPollingService.onValueUpdate = handler
    fundsPollingService.startPollingWith(parameter: settingsService.getDefaultRequestParameters().currencyCode)
  }
}
