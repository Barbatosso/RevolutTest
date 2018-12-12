//
//  FundsViewModelOutput.swift
//  RevolutTest
//
//  Created by Egor Petrov on 12/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

protocol FundsViewModelOutput: class {

  func setupTableView(with rows: [Row])
}
