//
//  CategoryCellViewModel.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 05.07.2023.
//

import Foundation
import UIKit

protocol CommonCellViewModel {
    
    func set(indexPath: IndexPath)
    func numberOfSections() -> Int
    func numberOfItemsInSection() -> Int
}


class CategoryCellViewModel : CommonCellViewModel {
        
    let categories : [CategoryCellModel] = [
        CategoryCellModel(title: "Phones", image: UIImage(named: "phonesCircle") ?? UIImage()),
        CategoryCellModel(title: "Computer", image: UIImage(named: "computerCircle") ?? UIImage()),
        CategoryCellModel(title: "Health", image: UIImage(named: "healthCircle") ?? UIImage()),
        CategoryCellModel(title: "Books", image: UIImage(named: "booksCircle") ?? UIImage()),
        CategoryCellModel(title: "Others", image: UIImage(named: "othersCircle") ?? UIImage())
    ]
    
    var index = 0
    
    var title: String {
        categories[index].title
    }
    
    var picture: UIImage {
        categories[index].image.imageWithColor(color: .gray)
    }
    
    func set(indexPath: IndexPath) {
        index = indexPath.row
    }

    func numberOfSections() -> Int {
        1
    }

    func numberOfItemsInSection() -> Int {
        categories.count
    }

}



    
    



