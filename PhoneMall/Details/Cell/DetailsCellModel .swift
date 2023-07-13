//
//  DetailsCellModel .swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 13.07.2023.
//

import Foundation
 
protocol DetailsCellModelProtocol {
    var title: String { get }
    var isFavorites: Bool { get set }
    var price: Int { get }
    var images: String { get }
}

class DetailsCellModel : DetailsCellModelProtocol {
    
    var title: String
    
    var isFavorites: Bool
    
    var price: Int
    
    var images: String
    
    init(title: String, isFavorites: Bool, price: Int, images: String) {
        self.title = title
        self.isFavorites = isFavorites
        self.price = price
        self.images = images
    }
    
}
