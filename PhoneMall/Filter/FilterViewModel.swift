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
//    
//    func numberOfRows(_ filter: FilterOptions) -> Int
//    func getRowValue(at index: Int, for filter: FilterOptions) -> String
//    //func getViewModel(for filter: FilterOptions) -> FilterViewModelProtocol
//    
//    init(brands: [String], prices: [String], sizes: [String])
}

class FilterViewModel : FilterViewModelProtocol {
    
    let data = FilterData()
        
    init() {
        sortModels()
    }
    
    func getModels() -> [PhoneName] {
        return data.phoneModels
    }
    
    func getSortedModels() -> [PhoneOptions] {
        return data.optionsSortedByModelsId
    }
    var title: String {
        "Filter Options"
    }
    
    
    func getOptions(phone_id: Int) -> [PhoneOptions] {
        let optionPhones = data.phoneModelsOptions.filter { (options) in
            options.phone_id == phone_id
        }
        return optionPhones
    }
    
    var optionsSortedByModelsId = [PhoneOptions]()
    
    private func sortModels() {
        self.optionsSortedByModelsId = getOptions(phone_id: data.phoneModels.first!.id)
    }
    
//    func numberOfRows(_ filter: FilterOptions) -> Int {
//        switch filter {
//        case .brand:
//           return brands.count
//        case .price:
//            return prices.count
//        case .size:
//            return  sizes.count
//        }
//    }
//    
//    func getRowValue(at index: Int, for filter: FilterOptions) -> String {
//        switch filter {
//        case .brand:
//            return  brands[index]
//        case .price:
//            return  prices[index]
//        case .size:
//            return  sizes[index]
//        }
//    }
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
    
//    required init(brands: [String], prices: [String], sizes: [String]) {
//        self.brands = brands
//        self.prices = prices
//        self.sizes = sizes
//    }
    
    
}
