//
//  FilterViewModel.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 28.07.2023.
//

import Foundation
import UIKit

enum FilterOptions {
    case brand
    case price
    case size
}

protocol FilterViewModelProtocol {
    var title: String { get }
    
    func numberOfRows(_ filter: FilterOptions) -> Int
    func getRowValue(at index: Int, for filter: FilterOptions) -> String
    //func getViewModel(for filter: FilterOptions) -> FilterViewModelProtocol
    
    init(brands: [String], prices: [String], sizes: [String])
}

class FilterViewModel : FilterViewModelProtocol {
    
    private var brands: [String]
    private let prices: [String]
    private let sizes: [String]
    
    var title: String {
        "Filter Options"
    }
    
    func numberOfRows(_ filter: FilterOptions) -> Int {
        switch filter {
        case .brand:
           return brands.count
        case .price:
            return prices.count
        case .size:
            return  sizes.count
        }
    }
    
    func getRowValue(at index: Int, for filter: FilterOptions) -> String {
        switch filter {
        case .brand:
            return  brands[index]
        case .price:
            return  prices[index]
        case .size:
            return  sizes[index]
        }
    }
//
//    func getViewModel(for filter: FilterOptions) -> FilterViewModelProtocol {
//        switch filter {
//        case .brand:
//            return FilterViewModel(brands: <#T##[String]#>, prices: <#T##[String]#>, sizes: <#T##[String]#>)
//        case .price:
//            <#code#>
//        case .size:
//            <#code#>
//        }
//    }
    
    required init(brands: [String], prices: [String], sizes: [String]) {
        self.brands = brands
        self.prices = prices
        self.sizes = sizes
    }
    
    
}
