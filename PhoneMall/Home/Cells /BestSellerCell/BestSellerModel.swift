//
//  BestSellerCellViewModel.swift
//
//  Created by Семен Гайдамакин on 28.06.2023.
//

import Foundation

protocol BestSellerModelProtocol {
    var title: String? { get }
    var discountPrice : String? { get }
    var fullPrice : String? { get }
    var pictureUrlString : String? { get }
    var isFavorites: Bool? { get set }
}

class BestSellerModel: BestSellerModelProtocol {
    
    private let isFavoritesKey = "isFavoritesKey"
    
    var title: String?
    var discountPrice : String?
    var fullPrice : String?
    var pictureUrlString : String?
    
    var isFavorites: Bool? {
        didSet {
            saveIsFavorites()
        }
    }
    
    func saveIsFavorites() {
        UserDefaults.standard.set(isFavorites, forKey: isFavoritesKey)
        
    }
    
    func loadIsFavorites() {
       isFavorites = UserDefaults.standard.bool(forKey: isFavoritesKey)
        

    }
    
    init(title: String?, discountPrice: String?, fullPrice: String?, pictureUrlString: String?, isFavorites: Bool?) {
        self.title = title
        self.discountPrice = discountPrice
        self.fullPrice = fullPrice
        self.pictureUrlString = pictureUrlString
        self.isFavorites = isFavorites
        
        loadIsFavorites()
        
    }

}
    

