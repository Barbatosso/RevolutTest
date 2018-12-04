//
//  FundsModuleFabric.swift
//  RevolutTest
//
//  Created by Egor Petrov on 02/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

struct FundsModuleFabric {

  func assemble() -> FundsModule {
    let settingsService = RequestSettingsServiceImpl(userDefaults: UserDefaults.standard)
    let configService = ConfigService()
    let mapper = JsonObjectMapper()
    let apiService = ApiService(configService: configService, mapper: mapper)
    let fundsService = FundsServiceImpl(apiService: apiService)
    let pollService = FundsPollingService(fundsService: fundsService, configService: configService)

    let viewModel = FundsViewModelImpl(settingsService: settingsService, fundsPollingService: pollService)
    let tableManager = TableManagerImpl()
    let viewController = FundsViewController(tableManager: tableManager, viewModel: viewModel)
    return viewController
  }
}
