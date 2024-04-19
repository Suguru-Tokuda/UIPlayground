//
//  NetworkManager.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 4/19/24.
//

import Combine
import Foundation

protocol Networking {
    func getData<T: Decodable>(url: URL, type: T.Type, completion: @escaping ((Result<T, Error>) -> Void))
    func getData<T: Decodable>(url: URL, type: T.Type) async throws -> T
    func getData<T: Decodable>(url: URL, type: T.Type) -> AnyPublisher<T, Error>
}

class NetworkManager: Networking {
    func getData<T: Decodable>(url: URL, type: T.Type, completion: @escaping ((Result<T, Error>) -> Void)) {
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                if let response {
                    completion(.failure(NetworkError.invalidResponse(response)))
                }
                completion(.failure(NetworkError.unknown))
                return
            }

            guard 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(NetworkError.badStatusCode(httpResponse.statusCode)))
                return
            }

            if let data {
                do {
                    let parsedData = try JSONDecoder().decode(type.self, from: data)
                } catch {
                    completion(.failure(NetworkError.dataParse(data)))
                }
            }
        }
    }

    func getData<T: Decodable>(url: URL, type: T.Type) async throws -> T {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse(response)
            }

            guard 200..<300 ~= httpResponse.statusCode else {
                throw NetworkError.badStatusCode(httpResponse.statusCode)
            }

            do {
                let parsedData = try JSONDecoder().decode(type.self, from: data)
                return parsedData
            } catch {
                throw NetworkError.dataParse(data)
            }
        } catch {
            throw NetworkError.invalidUrl(url)
        }
    }

    func getData<T: Decodable>(url: URL, type: T.Type) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse(response)
                }

                guard 200..<300 ~= httpResponse.statusCode else {
                    throw NetworkError.badStatusCode(httpResponse.statusCode)
                }

                do {
                    let parsedData = try JSONDecoder().decode(type.self, from: data)
                    return parsedData
                } catch {
                    throw NetworkError.dataParse(data)
                }
            }
            .eraseToAnyPublisher()
    }
}
