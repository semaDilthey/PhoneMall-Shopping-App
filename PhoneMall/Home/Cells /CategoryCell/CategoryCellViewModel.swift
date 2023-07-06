//
//  CategoryCellViewModel.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 05.07.2023.
//

import Foundation
import UIKit

protocol CommonCellViewModel {
    var title : String { get }
    var picture : String { get }
    
    func numberOfSections() -> Int
    func numberOfItemsInSection() -> Int
    func configure(cell: UICollectionViewCell, at indexPath: IndexPath)
    
}

class CategoryCellViewModel : CommonCellViewModel {

    var title: String = ""

    var picture: String = ""

    func numberOfSections() -> Int {
        1
    }

    func numberOfItemsInSection() -> Int {
        CategoryCellTitles.allCases.count
    }

    func configure(cell: UICollectionViewCell, at indexPath: IndexPath) {
    }


}

enum CategoryCellTitles: String, CaseIterable {
    case Phones, Computer, Health, Books, Others
    
    var nameImage : String {
        switch self {
        case .Phones:
            return "phonesCircle"
        case .Computer:
            return "computerCircle"
        case .Health:
            return "healthCircle"
        case .Books:
            return  "booksCircle"
        case .Others:
            return  "others"
        }
    }
    
    var title: String {
        switch self {
        case .Phones:
            return "Phones"
        case .Computer:
            return "Computer"
        case .Health:
            return "Health"
        case .Books:
            return  "Books"
        case .Others:
            return  "Others"
        }
    }
}
