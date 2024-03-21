//
//  String.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 3/20/24.
//

import Foundation

extension Double {
    func toCurrencyStr() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        return formatter.string(from: self as NSNumber) ?? ""
    }
}
