//
//  NetworkError.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 4/19/24.
//

import Foundation

enum NetworkError: Error {
    case badStatusCode(Int),
         invalidUrl(URL),
         invalidResponse(URLResponse),
         dataParse(Data),
         noData,
         unknown
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badStatusCode(let statusCode):
            return NSLocalizedString("badStatusCode", comment: "Bad status code: \(statusCode)")
        case .invalidUrl(let url):
            return NSLocalizedString("invalidUrl", comment: "Invalid url: \(url.absoluteString)")
        case .invalidResponse(let response):
            return NSLocalizedString("invalidResponse", comment: "Invalid response \(response)")
        case .dataParse(let data):
            return NSLocalizedString("dataParse", comment: "Data parse error")
        case .noData:
            return NSLocalizedString("noData", comment: "No data")
        case .unknown:
            return NSLocalizedString("unknown", comment: "Unknown")
        }
    }
}
