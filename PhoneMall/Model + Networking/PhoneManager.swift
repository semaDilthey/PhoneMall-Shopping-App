////
////  PhoneManager.swift
////  PhoneMall
////
////  Created by Семен Гайдамакин on 22.08.2022.
////
//
import Foundation
import UIKit

//protocol PhoneManagerDelegate {
//    func didUpdatePhone(_ phoneManager: PhoneManager)
//    func didFailWithError(error: Error)
//}

class PhoneManager {
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
}


