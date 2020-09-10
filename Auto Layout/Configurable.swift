//
//  Configurable.swift
//  Sample
//
//  Created by Zev Eisenberg on 9/10/20.
//  Copyright © 2020 The New York Times. All rights reserved.
//

import CoreGraphics

protocol Configurable {}

extension Configurable {
  func configure(_ closure: (inout Self) -> Void) -> Self {
    var mutable = self
    closure(&mutable)
    return mutable
  }
}

extension NSObject: Configurable {}
extension UIEdgeInsets: Configurable {}
extension CGPoint: Configurable {}
extension CGRect: Configurable {}
extension CGSize: Configurable {}
extension CGVector: Configurable {}
extension Array: Configurable {}
extension Dictionary: Configurable {}
extension Set: Configurable {}

