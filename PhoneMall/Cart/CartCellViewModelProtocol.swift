//
//  CartCellViewModelProtocol.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 07.04.2023.
//

import Foundation
import UIKit

protocol CartCellViewModelProtocol {
    
    var namePhone : String { get }
    var price : String { get }
    var counter : String { get }  // счетчик товара на +/-
    
    // ну и дальше надо будет писать
}
