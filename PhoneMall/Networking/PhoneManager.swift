////
////  PhoneManager.swift
////  PhoneMall
////
////  Created by Семен Гайдамакин on 22.08.2022.
////
//
import Foundation
import UIKit


protocol Networking {
    func request(url: String, completion: @escaping (Data?, Error?) -> Void)
}

protocol GetData {
    func getHomeScreenData(response: @escaping (HomeData?) -> Void)
    func getDetailsScreenData(response: @escaping (ProductDetailsData?) -> Void)
    func getCartScreenData(response: @escaping (HomeData?) -> Void)
}



class PhoneManager /*Networking*/ {
    
    var homePhones : [HomeData] = []
  
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
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
    
    func getHomeScreenData(path: String, completion: @escaping (HomeData?, Error?) -> Void) {
        var phonesArr = [HomeData]()
        networking.request(url: path) { (data, error) in
            guard let url = URL(string: path) else {
                fatalError("Invalid URL: \(path)")
            }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(nil, error)
                    return
                }
                guard let data = data else {
                    completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                    return
                }
                do {
                    let homeVCData = try? self.decodeJSON(type: HomeData.self, from: data)
                    completion(homeVCData, nil)
                    //self.homePhones = homeVCData
                   // print(phonesArr)
                } catch {
                    completion(nil, error)
                }
                
            }.resume()
        }
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

