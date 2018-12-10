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

  init() {
    observableText = Observable<String>(value: nil)
    super.init(frame: .zero)

    self.addTarget(self, action: #selector(observeTextChanges), for: .editingChanged)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  @objc private func observeTextChanges(_ textField: UITextField) {
    guard let text = textField.text else { return }
    observableText.value = text
  }
}
