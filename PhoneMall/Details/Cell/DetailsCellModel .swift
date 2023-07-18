//
//  DetailsCellModel .swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 13.07.2023.
//

import Foundation
 
protocol DetailsCellModelProtocol {
    var images: [String]? { get }
}


protocol ModelForCartProtocol {
    var price: String? { get }
    var title: String? { get }
    var picture: String? { get }
}


class DetailsCellModel : DetailsCellModelProtocol {
    
    var images: [String]?
    
    init(images: [String]) {
     
        self.images = images
    }
    
}


struct ModelForCart: ModelForCartProtocol {
    
    var price: String?
    
    var title: String?
    
    var picture: String?
    
}
