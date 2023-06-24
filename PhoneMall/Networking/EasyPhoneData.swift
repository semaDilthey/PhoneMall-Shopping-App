//
//  EasyPhoneData.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 06.09.2022.
//

import Foundation
import UIKit

struct EasyBestSellerData {
    
    
    static let titles = ["Iphone 12", "Samsung Galaxy A71", "Xiaomi Mi 11 ultra"]
 
    static let subtitle = "Súper. Mega. Rápido."
    static let isNew = [true, false, false]
    static let picture = [UIImage(named: "bestSellerIphone"), UIImage(named: "bestSellerSamsung"), UIImage(named: "bestSellerXiaomi")]
    static let isBuy : Bool = true

}

struct EasyHomeStoreData {
    
    static let titles = ["Motorola One Edge", "Samsung Galaxy s20 Ultra", "Samsung Note 20 Ultra", "Xiaomi Mi 10 Pro"]
    static let isFavorites = true
    static let priceWithoutDiscount = ["400", "1500", "1500", "400"]
    static let discountPrice = ["300", "1047", "1047", "300"]
    static let picture = [UIImage(named: "homeStoreMotorola"), UIImage(named: "homeStoreSamsungGalaxy"), UIImage(named: "homeStoreSamsungNote"), UIImage(named: "homeStoreXiaomi")]
    

}
