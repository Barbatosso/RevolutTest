//
//  UIView+SafeArea.swift
//  RevolutTest
//
//  Created by Egor Petrov on 12/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit

extension UIView {

  var safeOrMarginLayoutGuide: UILayoutGuide {
    if #available(iOS 11.0, *) {
      return safeAreaLayoutGuide
    } else {
      return layoutMarginsGuide
    }
  }
}
