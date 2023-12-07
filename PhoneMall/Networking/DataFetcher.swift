//
//  DataFetcher.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 06.12.2023.
//

import Foundation

protocol DataFetcherProtocol : AnyObject {
    func getData<T: Decodable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void)
}

class DataFetcher : DataFetcherProtocol {
    
    func getData<T:Decodable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
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
            let decodedData = self.decodeJSON(type: T.self, from: data)
            completion(.success(decodedData!))
        }
        task.resume()
    }
  

  private func decodeJSON <T: Decodable>(type: T.Type, from data: Data?) -> T? {
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      guard let data = data else { return nil }
      do {
          let response = try? decoder.decode(type.self, from: data)
          return response
      } catch let jsonError {
          print("Failed to decode JSON, \(jsonError)")
          return nil
      }
  }
}


enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case jsonParsingFailed
}
