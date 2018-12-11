//
//  MockViewHolderViewController.swift
//  RevolutTestTests
//
//  Created by Egor Petrov on 12/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit

class MockViewHolderViewController: UIViewController, ViewHolder {

  typealias RootViewType = MockViewHolderView

  init() {
    super.init(nibName: nil, bundle: nil)

    view = MockViewHolderView()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
