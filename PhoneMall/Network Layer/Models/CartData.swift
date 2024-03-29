

import Foundation

struct CartData: Decodable {
    
    let basket: [BasketCartData]
    let delivery: String
    let total: Int
}

struct BasketCartData: Decodable {
    
    let id: Int
    let images: String
    let price: Int
    let title: String
}
