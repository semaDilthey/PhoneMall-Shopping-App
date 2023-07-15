//
//  CartCellViewModel.swift
//  PhoneMall
//

import Foundation

protocol MyCartCellModelProtocol {
    
    var title : String? { get }
    var price : String? { get }
    var picture : String? { get }
    //var counter : String? { get }  // счетчик товара на +/-
    
}

class MyCartCellModel: MyCartCellModelProtocol {
    
    var title : String? = ""
    
    var price : String? = ""
    
    var picture : String?
    
    //var counter : String? = ""
    
    init(title: String, picture: String, price: String) {
        self.title = title
        self.picture = picture
        self.price = price
    }
    
}
