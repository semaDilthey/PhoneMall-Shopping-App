////
////  PhoneManager.swift
////  PhoneMall
////
////  Created by Семен Гайдамакин on 22.08.2022.
////
//
import Foundation
import UIKit



protocol GetData {
    func getHomeScreenData(completion: @escaping (Result<HomeData, Error>) -> Void)
    func getDetailsScreenData(completion: @escaping (Result<ProductDetailsData, Error>) -> Void)
    func getCartScreenData(completion: @escaping (Result<CartData, Error>) -> Void)
}



class NetworkManager: GetData {
    
    var homePhones : [HomeData] = []
    
    func getHomeScreenData(completion: @escaping (Result<HomeData, Error>) -> Void) {
        guard let url = URL(string: API.home) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }

            guard let httpsResponse = response as? HTTPURLResponse, httpsResponse.statusCode == 200 else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let parsedData = try? decoder.decode(HomeData.self, from: data) {
                //if let parsedData = try self.decodeJSON(type: HomeData.self, from: data) {
                    completion(.success(parsedData))
                } else {
                    completion(.failure(NetworkError.jsonParsingFailed))
                }
            } catch {
                completion(.failure(NetworkError.jsonParsingFailed))
            }
        }.resume()
    }
    

    
    func getDetailsScreenData(completion: @escaping (Result<ProductDetailsData, Error>) -> Void) {
        guard let url = URL(string: API.details) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let httpsResponse = response as? HTTPURLResponse, httpsResponse.statusCode == 200 else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let parsedData = try? decoder.decode(ProductDetailsData.self, from: data) {
                    completion(.success(parsedData))
                } else {
                    completion(.failure(NetworkError.jsonParsingFailed))
                }
            } catch {
                completion(.failure(NetworkError.jsonParsingFailed))
            }
        }.resume()
    }
    
    
    func getCartScreenData(completion: @escaping (Result<CartData, Error>) -> Void) {
        guard let url = URL(string: API.cart) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }

            guard let httpsResponse = response as? HTTPURLResponse, httpsResponse.statusCode == 200 else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let parsedData = try? decoder.decode(CartData.self, from: data) {
                    completion(.success(parsedData))
                } else {
                    completion(.failure(NetworkError.jsonParsingFailed))
                }
            } catch {
                completion(.failure(NetworkError.jsonParsingFailed))
            }
        }.resume()
    }
    
    

    private func decodeJSON <T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase 
        guard let data = data, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}


enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case jsonParsingFailed
}
