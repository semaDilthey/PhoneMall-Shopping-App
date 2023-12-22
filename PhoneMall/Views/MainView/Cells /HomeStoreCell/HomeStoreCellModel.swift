

import Foundation

// Протокол, представляющий модель представления хоум ячейки
protocol HomeStoreCellModelProtocol {
    var title: String? { get }
    var subtitle : String? { get }
    var pictureUrlString : String? { get }
}

class HomeStoreCellModel: HomeStoreCellModelProtocol {
    var pictureUrlString: String?
    let title : String?
    let subtitle : String?

    init(title: String, subtitle: String, picture: String) {
        self.title = title
        self.subtitle = subtitle
        self.pictureUrlString = picture
    }
}
