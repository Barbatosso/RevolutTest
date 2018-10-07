//
//  ApiRequester.swift
//  RevolutTest
//
//  Created by Egor Petrov on 07/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

protocol ApiRequester {

  func runRequest(for target: ApiTarget, with completionHandler: @escaping(Data?, Error?) -> Void)
}
