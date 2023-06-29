//
//  DataManager.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 21.08.2022.
//

import Foundation
import UIKit


struct HomeVCData : Decodable {
    
    let homeStore : [HomeStoreItem]
    let bestSeller : [BestSellerItem]
}

struct HomeStoreItem : Decodable {
    let id : Int
    let title : String
    let subtitle : String
    let isNew : Bool?
    let picture : String
    let isBuy : Bool
}

struct BestSellerItem : Decodable {
    let id : Int
    let isFavorites : Bool
    let title : String
    let priceWithoutDiscount : Int
    let discountPrice : Int
    let picture : String

}
