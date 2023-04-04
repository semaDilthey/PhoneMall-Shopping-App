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

//struct PhoneManager {
////
//    //var phonesArray = [PhoneData]()
////
////    var delegate: PhoneManagerDelegate? //свойство для делегирования по протоколу
////
//    let phoneURL = "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175"
//
//    mutating func getJSON(with urlString : String) { // функция выполяющая запрос  через URLSession
//        guard let url = URL(string: urlString) else {
//                fatalError("guard URL failed")
//            }
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let data = data {
//                guard let phone = try? JSONDecoder().decode(PhoneData.self, from: data) else {
//                    fatalError("Something wrong with JSON Decoder, code: \(error!)")
//                }
//                DispatchQueue.main.async {
//                    HomeVC().array.append(phone)
//
//                }
//                print(HomeVC().array)
//            }
//        }
//        .resume()
//    }
//
//}


