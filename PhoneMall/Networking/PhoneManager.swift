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
    func getHomeScreenData(completion: @escaping (Result<Data, Error>) -> Void)
    func getDetailsScreenData(response: @escaping (ProductDetailsData?) -> Void)
    func getCartScreenData(response: @escaping (HomeData?) -> Void)
}



class PhoneManager /*Networking*/ {
    
    var homePhones : [HomeData] = []
  
    
  //Массивчик, в который будет погружаться все что мы парсим
    
////    var delegate: PhoneManagerDelegate? //свойство для делегирования по протоколу
//
//    let phoneURL = "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175"
//
//    
//    func getJSON(with urlString : String) { // функция выполяющая запрос  через URLSession
//        guard let url = URL(string: urlString) else {
//                fatalError("guard URL failed")
//            }
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let data = data {
//                guard let phone = try? JSONDecoder().decode(HomeVCData.self, from: data) else {
//                    fatalError("Something wrong with JSON Decoder, code: \(error!)")
//                }
//               DispatchQueue.main.async {
//                     self.phonesArray.append(phone)
//                }
//                print(self.phonesArray)
//
//            }
//        }
//        .resume()
//    }
//
    
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
    
    func getDetailsScreenData(response: @escaping (ProductDetailsData?) -> Void) {
        
    }
    
    func getCartScreenData(response: @escaping (HomeData?) -> Void) {
        
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
