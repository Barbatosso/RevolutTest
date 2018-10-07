//
//  FundsService.swift
//  RevolutTest
//
//  Created by Egor Petrov on 07/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

protocol FundsService {

  func fetchFunds(for base: String, with completion: @escaping (FundsType?, Error?) -> Void)
}

struct FundsServiceImpl: FundsService {

  private let apiService: ApiService<Funds>

  init(apiService: ApiService<Funds>) {
    self.apiService = apiService
  }

  func fetchFunds(for base: String, with completion: @escaping (FundsType?, Error?) -> Void) {
    apiService.runRequest(for: FundsServiceTarget.funds(base: base)) { funds, error in
      completion(funds, error)
    }
  }
}
