//
//  DataManager.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 21.08.2022.
//

import Foundation

struct HomeVCData : Decodable {
    
    let homeStore : [HomeStore]
    let bestSeller : [BestSeller]
}

struct HomeStore : Decodable {
    let id : Int
    let title : String
    let subtitle : String
    let isNew : Bool?
    let picture : String
    let isBuy : Bool
}

struct BestSeller : Decodable {
    let id : Int
    let isFavorites : Bool
    let title : String
    let priceWithoutDiscount : Int
    let discountPrice : Int
    let picture : String

}
