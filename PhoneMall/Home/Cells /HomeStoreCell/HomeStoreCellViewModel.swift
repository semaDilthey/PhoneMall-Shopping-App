//
//  HomeStoreCellViewModel.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 29.06.2023.
//

import Foundation

class HomeStoreCellViewModel {
    
    let title : String?
    let subtitle : String?
    let picture : String?
    
    init(data: HomeStoreItem) {
        self.title = data.title
        self.subtitle = data.subtitle
        self.picture = data.picture
    }
}
