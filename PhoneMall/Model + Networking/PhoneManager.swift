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
    func getHomeScreenData(response: @escaping (HomeVCData?, Error?) -> Void)
    func getDetailsScreenData(response: @escaping (ProductDetailsVCData?, Error?) -> Void)
    func getCartScreenData(response: @escaping (HomeVCData?, Error?) -> Void)
}

//protocol PhoneManagerDelegate {
//    func didUpdatePhone(_ phoneManager: PhoneManager)
//    func didFailWithError(error: Error)
//}

class PhoneManager: GetData {
    
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
    func getHomeScreenData(response: @escaping (HomeVCData?, Error?) -> Void){
    }
    
    func getDetailsScreenData(response: @escaping (ProductDetailsVCData?, Error?) -> Void) {
        
    }
    
    func getCartScreenData(response: @escaping (HomeVCData?, Error?) -> Void) {
        
    }
    
    private func decodeJSON <T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase 
        guard let data = data, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}

