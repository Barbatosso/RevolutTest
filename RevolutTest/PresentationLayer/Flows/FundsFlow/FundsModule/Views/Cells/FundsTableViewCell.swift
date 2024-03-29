//
//  FundsTableViewCell.swift
//  RevolutTest
//
//  Created by Egor Petrov on 11/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit
import SnapKit

class FundsTableViewCell: UITableViewCell, ConfigurableCell {

  private let imageSizeDimension = 60

  private let flagImageView: UIImageView = {
    let imageView = RoundImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private let fundTitleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14, weight: .light)
    label.textColor = .gray
    label.textAlignment = .left
    return label
  }()

  let fundsTextField: UnderlinedObservableTextField = {
    let textField = UnderlinedObservableTextField()
    textField.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    textField.textColor = .black
    textField.textAlignment = .right
    textField.isEnabled = false
    textField.keyboardType = .numberPad
    return textField
  }()

  override func becomeFirstResponder() -> Bool {
    super.becomeFirstResponder()

    fundsTextField.placeholder = String(1.0)
    fundsTextField.observableText.value = fundsTextField.placeholder
    fundsTextField.isEnabled = true
    fundsTextField.becomeFirstResponder()
    return true
  }

  override func resignFirstResponder() -> Bool {
    super.resignFirstResponder()

    fundsTextField.isEnabled = false
    fundsTextField.resignFirstResponder()
    fundsTextField.observableText.cleanAllObservers()
    return true
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    contentView.addSubview(flagImageView)
    contentView.addSubview(fundTitleLabel)
    contentView.addSubview(fundsTextField)

    flagImageView.snp.makeConstraints { make in
      make.size.equalTo(imageSizeDimension)
      make.centerY.equalToSuperview()
      make.leading.equalTo(snp.leadingMargin)
      make.top.bottom.equalTo(contentView)
    }

    fundTitleLabel.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.equalTo(flagImageView.snp.trailing).offset(10)
    }

    fundsTextField.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.greaterThanOrEqualTo(fundTitleLabel.snp.trailing).offset(10)
      make.trailing.equalTo(snp.trailingMargin)
    }
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setNewFund(_ value: Double) {
    fundsTextField.text = string(for: value)
  }

  func configure(with data: FundsItem) {
    flagImageView.image = UIImage(named: data.fundsCode)
    fundTitleLabel.text = data.fundsCode
    fundsTextField.text = string(for: data.value)
    fundsTextField.delegate = self
  }

  private func string(for value: Double) -> String {
    return String(format: "%.3f", value)
  }
}

extension FundsTableViewCell: UITextFieldDelegate {

  func textFieldDidBeginEditing(_ textField: UITextField) {
    textField.text = nil
  }
}
