//
//  ViewHolder.swift
//  RevolutTest
//
//  Created by Egor Petrov on 23/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit.UIViewController

protocol ViewHolder: class {

  associatedtype RootViewType: UIView

  var rootView: RootViewType { get }
}

extension ViewHolder where Self: UIViewController {

  var rootView: RootViewType {
    guard let rootView = view as? RootViewType else {
      fatalError("Excpected \(RootViewType.description()) as rootView. Now \(type(of: view))")
    }
    return rootView
  }
}
