//
//  LocalizedString.swift
//  RevolutTest
//
//  Created by Egor Petrov on 07/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit

extension String {

  var localized: String {
    return NSLocalizedString(self, comment: "")
  }
}
