//
//  HomeStoreCellViewModel.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 29.06.2023.
//

import Foundation

protocol HomeStoreCellViewModelProtocol {
    var title: String? { get }
    var subtitle : String? { get }
    var pictureUrlString : String? { get }
}

class HomeStoreCellViewModel: HomeStoreCellViewModelProtocol {
    var pictureUrlString: String?
    let title : String?
    let subtitle : String?

    init(title: String, subtitle: String, picture: String) {
        self.title = title
        self.subtitle = subtitle
        self.pictureUrlString = picture
    }
}
