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
    
    let parser : Parser = Parser()
    
    // open-closed принцип, все дела, метод для получения данных с инета
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
            self.parser.decodeJSON(ofType: T.self, from: data, completion: completion)
        }
        task.resume()
    }
  

}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case jsonParsingFailed
}
