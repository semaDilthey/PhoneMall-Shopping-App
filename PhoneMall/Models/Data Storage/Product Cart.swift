//
//  Product Cart.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 13.11.2023.
//

import Foundation
import UIKit

struct ProductCart: Codable {
    let name: String
    var count: Int
    let price: String
    let image: String
    
    init(model bs: BestSellerModel) {
        self.name = bs.title ?? "NaN"
        self.count = 1
        self.price = bs.discountPrice ?? "0"
        self.image = bs.pictureUrlString ?? "NaN"
    }
    
//    init(basketData: BasketCardData) {
//        self.id = basketData.id
//        self.name = basketData.title
//        self.count = 1
//        self.price = basketData.price
//        self.image = basketData.images
//    }
}
