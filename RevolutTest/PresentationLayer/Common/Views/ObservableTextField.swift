//
//  ObservableTextField.swift
//  RevolutTest
//
//  Created by Egor Petrov on 05/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit

class ObservableTextField: UITextField {

  let observableText: Observable<String>

  override var text: String? {
    didSet {
      observableText.value = text
    }
  }

  init() {
    observableText = Observable<String>(value: nil)
    super.init(frame: .zero)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
