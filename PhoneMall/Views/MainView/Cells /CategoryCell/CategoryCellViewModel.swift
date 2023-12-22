

import Foundation
import UIKit

protocol CommonCellViewModel {
    
    func set(indexPath: IndexPath)
    func numberOfSections() -> Int
    func numberOfItemsInSection() -> Int
}


class CategoryCellViewModel: CommonCellViewModel {
    
    // Массив категорий
    private let categories: [CategoryCellModel] = [
        CategoryCellModel(title: "Phones", image: UIImage(named: "phonesCircle") ?? UIImage()),
        CategoryCellModel(title: "Computer", image: UIImage(named: "computerCircle") ?? UIImage()),
        CategoryCellModel(title: "Health", image: UIImage(named: "healthCircle") ?? UIImage()),
        CategoryCellModel(title: "Books", image: UIImage(named: "booksCircle") ?? UIImage()),
        CategoryCellModel(title: "Others", image: UIImage(named: "othersCircle") ?? UIImage())
    ]
    
    // Текущий индекс выбранной категории
    private var selectedIndex = 0
    
    // Заголовок текущей выбранной категории
    var title: String {
        categories[selectedIndex].title
    }
    
    // Изображение текущей выбранной категории с серым цветом
    var picture: UIImage {
        categories[selectedIndex].image.imageWithColor(color: .gray)
    }
    
    // Установка текущего индекса на основе IndexPath
    func set(indexPath: IndexPath) {
        guard indexPath.row < categories.count else {
            return
        }
        selectedIndex = indexPath.row
    }
    
    // Количество секций (в данном случае всегда 1)
    func numberOfSections() -> Int {
        1
    }
    
    // Количество элементов в секции (количество категорий)
    func numberOfItemsInSection() -> Int {
        categories.count
    }
    
    
}
    
    



