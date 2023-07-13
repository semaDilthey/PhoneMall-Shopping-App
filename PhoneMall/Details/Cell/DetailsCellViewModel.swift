//
//  DetailsCellViewModel.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 13.07.2023.
//

import Foundation
import UIKit

protocol DetailsCellProtocol {
    init(product: ProductDetailsData, networking: NetworkManager)
    
}

class DetailsCellViewModel: DetailsCellProtocol {
    
    var data : ProductDetailsData?
    
    var detailsModel : DetailsCellModelProtocol?
    
    var product: ProductDetailsData?
    var networking: NetworkManager?
    
    required init(product: ProductDetailsData, networking: NetworkManager) {
        self.product = product
        self.networking = networking
    }
    
    
    
    
    
    
}
