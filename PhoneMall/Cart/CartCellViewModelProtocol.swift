//
//  CartCellViewModelProtocol.swift
//  PhoneMall
//
//

import Foundation
import UIKit

protocol CartCellViewModelProtocol {
    
    var namePhone : String { get }
    var price : String { get }
    var counter : String { get }  // счетчик товара на +/-
    
    // ну и дальше надо будет писать
}
