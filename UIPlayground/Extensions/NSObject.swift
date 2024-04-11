//
//  NSObject.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 4/11/24.
//

import UIKit

extension NSObject {
    var className: String {
        get {
            return NSStringFromClass(type(of: self))
        }
    }
}
