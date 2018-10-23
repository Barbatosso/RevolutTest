//
//  FundsService.swift
//  RevolutTest
//
//  Created by Egor Petrov on 07/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

protocol FundsService {

  func fetchFunds(for base: String, with completion: @escaping (Funds?, Error?) -> Void)
}

struct FundsServiceImpl: FundsService {

  private let apiService: ApiService

  init(apiService: ApiService) {
    self.apiService = apiService
  }

  func fetchFunds(for base: String, with completion: @escaping (Funds?, Error?) -> Void) {
    apiService.runRequest(for: FundsServiceTarget.funds(base: base), with: completion)
  }
}
