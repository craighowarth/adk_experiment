//
//  Reusable.swift
//  Sample
//
//  Created by Zev Eisenberg on 9/4/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit

protocol Reusable {
  static var reuseIdentifier: String { get }
}

extension Reusable {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}

extension UICollectionView {
  func register<T: UICollectionViewCell & Reusable>(cell: T.Type) {
    register(cell, forCellWithReuseIdentifier: cell.reuseIdentifier)
  }

  func dequeue<T: UICollectionViewCell & Reusable>(for indexPath: IndexPath) -> T {
    dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
  }
}
