//
//  FilterData.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 28.08.2023.
//

import Foundation

struct PhoneName {
    var id : Int
    var name: String
}

struct PhoneOptions {
    var phone_id: Int
    var size: Double
    var price: Int
}

class FilterData{
    
    var phones = [PhoneName]()
    var phonesOptions = [PhoneOptions]()
    
    var optionsByPhones = [PhoneOptions]()
    
    init() {
        setupData()
    }
    
    func setupData() {
        
        let phone1 = PhoneName(id: 1, name: "iPhone")
        let phone2 = PhoneName(id: 2, name: "Samsung")
        let phone3 = PhoneName(id: 3, name: "Xiaomi")
        let phone4 = PhoneName(id: 4, name: "Motorolla")
        
        phones.append(phone1)
        phones.append(phone2)
        phones.append(phone3)
        phones.append(phone4)

        let phonesOption1 = PhoneOptions(phone_id: 1, size: 4.7, price: 1800)
        let phonesOption12 = PhoneOptions(phone_id: 1, size: 4.9, price: 1900)
        let phonesOption13 = PhoneOptions(phone_id: 1, size: 5.1, price: 2100)
        
        let phonesOption2 = PhoneOptions(phone_id: 2, size: 5.5, price: 1500)
        let phonesOption22 = PhoneOptions(phone_id: 2, size: 6.5, price: 1550)
        
        let phonesOption3 = PhoneOptions(phone_id: 3, size: 5.7, price: 400)
        let phonesOption32 = PhoneOptions(phone_id: 3, size: 5.9, price: 700)

        let phonesOption4 = PhoneOptions(phone_id: 4, size: 6.7, price: 400)
        let phonesOption42 = PhoneOptions(phone_id: 4, size: 6.8, price: 800)
        
        phonesOptions.append(phonesOption1)
        phonesOptions.append(phonesOption12)
        phonesOptions.append(phonesOption13)

        phonesOptions.append(phonesOption2)
        phonesOptions.append(phonesOption22)
        
        phonesOptions.append(phonesOption3)
        phonesOptions.append(phonesOption32)

        phonesOptions.append(phonesOption4)
        phonesOptions.append(phonesOption42)
        
        self.optionsByPhones = getOptions(phone_id: phones.first!.id)
        
    }
    
    func getOptions(phone_id: Int) -> [PhoneOptions] {
        let optionPhones = self.phonesOptions.filter { (options) in
            options.phone_id == phone_id
        }
        return optionPhones
    }
    
    
}
