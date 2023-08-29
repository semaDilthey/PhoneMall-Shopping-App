//
//  DetailsCellModel .swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 13.07.2023.
//

import Foundation
 
protocol DetailsCellModelProtocol {
    var images: [String]? { get }
    var price : Int? { get }
    var title : String? { get }
}


protocol ModelForCartProtocol {
    var price: String? { get }
    var title: String? { get }
    var picture: String? { get }
}


class DetailsCellModel : DetailsCellModelProtocol {
    var price: Int?
    
    var title: String?
    
    var images: [String]?
    
    init(images: [String]) {
        self.images = images
    }
    
    init(images: [String], price: Int, title: String) {
        self.images = images
        self.price = price
        self.title = title
    }
    
}


struct ModelForCart: ModelForCartProtocol {
    
    var price: String?
    
    var title: String?
    
    var picture: String?
    
}
