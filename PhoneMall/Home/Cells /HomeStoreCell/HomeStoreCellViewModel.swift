//
//  HomeStoreCellViewModel.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 29.06.2023.
//

import Foundation

class HomeStoreCellViewModel: InputHomeCellProtocol {
    var pictureUrlString: String?
    let title : String?
    let subtitle : String?

    init(data: HomeStoreItem) {
        self.title = data.title
        self.subtitle = data.subtitle
        self.pictureUrlString = data.picture
    }
}
