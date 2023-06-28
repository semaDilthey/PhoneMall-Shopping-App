//
//  CartCellViewModel.swift
//  PhoneMall
//

import Foundation

protocol CartCellViewModelProtocol {
    
    var namePhone : String { get }
    var price : String { get }
    var counter : String { get }  // счетчик товара на +/-
    
    // ну и дальше надо будет писать
}

class CartCellViewModel: CartCellViewModelProtocol {
    
    var namePhone: String = ""
    
    var price: String = ""
    
    var counter: String = ""
    
}
