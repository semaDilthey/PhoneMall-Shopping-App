

import Foundation
import UIKit

// Протокол, представляющий модель представления категории
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
