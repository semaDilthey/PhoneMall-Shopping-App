//
//  ProductDetailsVCData.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 03.04.2023.
//

import Foundation

struct ProductDetailsVCData: Codable {
    let title: String
    let isFavorites: Bool
    let CPU: String
    let camera: String
    let sd: String
    let ssd: String
    let capacity: [String]
    let color: [String]
    let price: Int
    let images: [String]
}
