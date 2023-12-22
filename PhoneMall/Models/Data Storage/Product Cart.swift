

import Foundation
import UIKit

struct ProductCart: Codable {
    let name: String
    var count: Int
    let price: String
    let image: String
    
    init(model: BestSellerModel) {
        self.name = model.title ?? "NaN"
        self.count = 1
        self.price = model.discountPrice ?? "0"
        self.image = model.pictureUrlString ?? "NaN"
    }
    
//    init(basketData: BasketCardData) {
//        self.id = basketData.id
//        self.name = basketData.title
//        self.count = 1
//        self.price = basketData.price
//        self.image = basketData.images
//    }
}
