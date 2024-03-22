//
//  LocalDataManager.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 3/20/24.
//

import Foundation

protocol LocalDataManaging {
    func getData<T: Decodable>(fileName: String, extensionStr: String, type: T.Type) throws -> T
}

class LocalDataManager: LocalDataManaging {
    func getData<T: Decodable>(fileName: String, extensionStr: String, type: T.Type) throws -> T {
        do {
            if let url = Bundle.main.url(forResource: fileName, withExtension: extensionStr) {
                var data: Data?

                do {
                    data = try Data(contentsOf: url)
                    if let data {
                        do {
                            let parsedData = try JSONDecoder().decode(type.self, from: data)
                            return parsedData
                        } catch {
                            print(error)
                            throw JsonDecoderError.parsing
                        }
                    } else {
                        throw JsonDecoderError.noData
                    }
                } catch {
                    print(error)
                    throw JsonDecoderError.noData
                }
            } else {
                throw JsonDecoderError.invalidUrl
            }
        } catch {
            throw error
        }
    }
}
