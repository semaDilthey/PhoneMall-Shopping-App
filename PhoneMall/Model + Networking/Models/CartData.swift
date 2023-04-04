//
//  CartData.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 03.04.2023.
//

import Foundation

struct CartData: Codable {
    let basket: [BasketCartData]
    let delivery: String
    let total: Int
}

struct BasketCartData: Codable {
    let id: Int
    let images: String
    let price: Int
    let title: String
}
