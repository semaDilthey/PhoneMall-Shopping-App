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
    func request(path: String, completion: @escaping (Data?, Error?) -> Void)
}

protocol GetData {
    func getHomeScreenData(response: @escaping (HomeVCData?) -> Void)
    func getDetailsScreenData(response: @escaping (ProductDetailsVCData?) -> Void)
    func getCartScreenData(response: @escaping (HomeVCData?) -> Void)
}

//protocol PhoneManagerDelegate {
//    func didUpdatePhone(_ phoneManager: PhoneManager)
//    func didFailWithError(error: Error)
//}

class PhoneManager: GetData {
  
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
  //Массивчик, в который будет погружаться все что мы парсим
    var phonesArray = [HomeVCData]()
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
    
    func getHomeScreenData(response: @escaping (HomeVCData?) -> Void){
        networking.request(path: API.home) { (data, error) in
            if let error = error {
                print("Error recieved requesting data : \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJSON(type: HomeVCData.self, from: data)
            response(decoded)
            print("AAAAAA")
        }
    }
    
    func getDetailsScreenData(response: @escaping (ProductDetailsVCData?) -> Void) {
        
    }
    
    func getCartScreenData(response: @escaping (HomeVCData?) -> Void) {
        
    }
    
    private func decodeJSON <T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase 
        guard let data = data, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}

