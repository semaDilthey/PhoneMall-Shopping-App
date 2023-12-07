

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
    
    var phoneModels : [PhoneName] = [PhoneName(id: 1, name: "iPhone"),
                                     PhoneName(id: 2, name: "Samsung"),
                                     PhoneName(id: 3, name: "Xiaomi"),
                                     PhoneName(id: 4, name: "Motorolla")]
    
    var phoneModelsOptions : [PhoneOptions] = [PhoneOptions(phone_id: 1, size: 4.7, price: 1800),
                                               PhoneOptions(phone_id: 1, size: 4.9, price: 1900),
                                               PhoneOptions(phone_id: 1, size: 5.1, price: 2100),
                                               PhoneOptions(phone_id: 2, size: 5.5, price: 1500),
                                               PhoneOptions(phone_id: 2, size: 6.5, price: 1650),
                                               PhoneOptions(phone_id: 3, size: 5.7, price: 400),
                                               PhoneOptions(phone_id: 3, size: 5.9, price: 700),
                                               PhoneOptions(phone_id: 4, size: 6.7, price: 530),
                                               PhoneOptions(phone_id: 4, size: 6.8, price: 800)]

    
}
