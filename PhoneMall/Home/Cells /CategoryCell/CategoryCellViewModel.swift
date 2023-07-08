//
//  CategoryCellViewModel.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 05.07.2023.
//

import Foundation
import UIKit

protocol CommonCellViewModel {
 
    func numberOfSections() -> Int
    func numberOfItemsInSection() -> Int
}

class CategoryCellViewModel : CommonCellViewModel {
    
    let categories : [CategoryCellModel] = [
        CategoryCellModel(title: "Phones", image: UIImage(named: "phonesCircle") ?? UIImage()),
        CategoryCellModel(title: "Computer", image: UIImage(named: "computerCircle") ?? UIImage()),
        CategoryCellModel(title: "Health", image: UIImage(named: "healthCircle") ?? UIImage()),
        CategoryCellModel(title: "Books", image: UIImage(named: "booksCircle") ?? UIImage()),
        CategoryCellModel(title: "Others", image: UIImage(named: "others") ?? UIImage())
    ]
    
    
    var title: String = ""
    
    var picture: String = ""
    

    func numberOfSections() -> Int {
        1
    }

    func numberOfItemsInSection() -> Int {
        categories.count
    }

}



    
    



