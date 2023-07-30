//
//  CategoryCellModel.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 07.07.2023.
//

import Foundation
import UIKit

protocol CategoryViewModel {
    var title : String { get }
    var image : UIImage { get }
}

class CategoryCellModel : CategoryViewModel{
    
    var title : String
    var image: UIImage

    init(title: String, image: UIImage) {
        self.title = title
        self.image = image

    }
}
