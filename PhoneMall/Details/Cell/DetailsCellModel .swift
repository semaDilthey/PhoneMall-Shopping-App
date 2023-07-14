//
//  DetailsCellModel .swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 13.07.2023.
//

import Foundation
 
protocol DetailsCellModelProtocol {
 
    var images: String? { get }
}

class DetailsCellModel : DetailsCellModelProtocol {
    
    var images: String?
    
    init(images: String) {
     
        self.images = images
    }
    
}
