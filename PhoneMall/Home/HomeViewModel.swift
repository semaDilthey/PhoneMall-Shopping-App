//
//  HomeViewModel.swift
//  PhoneMall
//
//

import Foundation

protocol HomeViewModelProtocol {
    func numberOfSections() -> Int
    func numberOfItemsInSection() -> Int
    func cellViewModel(forIndexPath IndexPath: IndexPath) -> CollectionViewCellModelProtocol?
    func setIndex(setIndex setIndex: IndexPath) -> Int
}

class HomeViewModel : HomeViewModelProtocol {
  
    
    
    var phones : PhoneManager?
    
    func setIndex(setIndex: IndexPath) -> Int {
        <#code#>
    }
    
    func numberOfSections() -> Int {
        phones?.phonesArray.count ?? 0
    }
    
    func numberOfItemsInSection() -> Int {
        <#code#>
    }
    
    func cellViewModel(forIndexPath IndexPath: IndexPath) -> CollectionViewCellModelProtocol? {
        <#code#>
    }
    
    
}
