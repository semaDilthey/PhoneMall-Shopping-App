

import Foundation
import UIKit

enum FilterOptions {
    case brand
    case price
    case size
}

protocol FilterViewModelProtocol {
    func getPhoneModels() -> [PhoneName]
    func getOptionsSortedByModelsId() -> [PhoneOptions]
    //func getOptions(forPhoneId phoneId: Int) -> [PhoneOptions]
}

class FilterViewModel : FilterViewModelProtocol {
    
    let filterData : FilterData
    
    init(filterData: FilterData) {
        self.filterData = filterData
        sortModels()
    }
    
    func getPhoneModels() -> [PhoneName] {
        return filterData.phoneModels
    }
    
    func getOptionsSortedByModelsId() -> [PhoneOptions] {
        return filterData.phoneModelsOptions
    }
    
    func getOptionsById(forPhoneId phoneId: Int) -> [PhoneOptions] {
        return filterData.phoneModelsOptions.filter { $0.phone_id == phoneId }
    }
    
    
    var title: String {
        "Filter Options"
    }
    
    func fetchOptions(phoneName : PhoneName, phoneOptions: [PhoneOptions]) -> PhoneOptions {
        var newOptions : PhoneOptions? = nil
        for options in phoneOptions {
            if phoneName.id == options.phone_id {
                newOptions = options
            }
        }
        return newOptions ?? PhoneOptions(phone_id: 1, size: 1, price: 1)
    }
    
    var optionsSortedByModelsId = [PhoneOptions]()
    
    
    private func sortModels() {
        self.getOptions(forPhoneName: filterData.phoneModels, phoneOptions: filterData.phoneModelsOptions)
    }
    
    func getOptions(forPhoneName phoneName: [PhoneName], phoneOptions: [PhoneOptions]) -> [PhoneOptions] {
        var ourArray : [PhoneOptions] = []
        for phoneId in phoneName {
            for phoneOptionsId in phoneOptions {
                if phoneId.id == phoneOptionsId.phone_id {
                    ourArray.append(phoneOptionsId)
                }
            }
        }
        print(ourArray)
        return ourArray
    }
}
    
    

