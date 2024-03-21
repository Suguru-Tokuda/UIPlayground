//
//  JsonDecoderError.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 3/20/24.
//

import Foundation

enum JsonDecoderError: String, Error {
    case parsing,
         noData,
         invalidUrl,
         unknown
}

extension JsonDecoderError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .parsing:
            return NSLocalizedString(self.rawValue, comment: "Parsing")
        case .noData:
            return NSLocalizedString(self.rawValue, comment: "No data")
        case .invalidUrl:
            return NSLocalizedString(self.rawValue, comment: "Invalid url")
        case .unknown:
            return NSLocalizedString(self.rawValue, comment: "Unknown error")
        }
    }
}
