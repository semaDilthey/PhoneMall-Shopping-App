//
//  BestSellerCellViewModel.swift
//
//  Created by Семен Гайдамакин on 28.06.2023.
//

import Foundation

class BestSellerCellViewModel {
    
    let title : String?
    let discountPrice : String?
    let fullPrice : String?
    let picture : String?
    
    init(data: BestSellerItem) {
        self.title = data.title
        self.discountPrice = String(data.discountPrice)
        self.fullPrice = String(data.priceWithoutDiscount)
        self.picture = data.picture
    }
    
}
