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
          getData(from: API.home, completion: completion)
      }
      
    func getDetailsScreenData(completion: @escaping (Result<ProductDetailsData, Error>) -> Void) {
          getData(from: API.details, completion: completion)
      }
      
    func getCartScreenData(completion: @escaping (Result<CartData, Error>) -> Void) {
          getData(from: API.cart, completion: completion)
      }

      // MARK: - Private Method
      
    private func getData<T: Decodable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
          guard let url = URL(string: urlString) else {
              completion(.failure(NetworkError.invalidURL))
              return
          }

          let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
              if let error = error {
                  completion(.failure(error))
                  return
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
                  if let parsedData = try? decoder.decode(T.self, from: data) {
                      completion(.success(parsedData))
                  } else {
                      completion(.failure(NetworkError.jsonParsingFailed))
                  }
              } catch {
                  completion(.failure(NetworkError.jsonParsingFailed))
              }
          }

          task.resume()
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
