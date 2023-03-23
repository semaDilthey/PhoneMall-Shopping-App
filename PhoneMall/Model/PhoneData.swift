////
////  DataManager.swift
////  PhoneMall
////
////  Created by Семен Гайдамакин on 21.08.2022.
////
//
//import Foundation
//
//struct PhoneData : Codable {
//    
//    let homeStore : [Store]
//    let bestSeller : [Seller]
//
//    enum CodingKeys :  String, CodingKey {
//        case homeStore = "home_store"
//        case bestSeller = "best_seller"
//    }
//}
//
//struct Store : Codable {
//    let id : Int
//    let title : String
//    let subtitle : String
//    let isNew : Bool?
//    let picture : String
//    let isBuy : Bool
//
//    enum CodingKeys : String, CodingKey {
//        case isNew = "is_new"
//        case isBuy = "is_buy"
//        case id = "id"
//        case title = "title"
//        case subtitle = "subtitle"
//        case picture = "picture"
//    }
//
//}
//
//struct Seller : Codable {
//    let id : Int
//    let isFavorites : Bool
//    let title : String
//    let priceWithoutDiscount : Int
//    let discountPrice : Int
//    let picture : String
//
//    enum CodingKeys : String, CodingKey {
//        case id = "id"
//        case title = "title"
//        case isFavorites = "is_favorites"
//        case priceWithoutDiscount = "price_without_discount"
//        case discountPrice = "discount_price"
//        case picture = "picture"
//    }
//}
