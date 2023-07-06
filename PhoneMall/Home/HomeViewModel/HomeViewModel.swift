//
//  HomeViewModel.swift
//  PhoneMall
//
//

import Foundation

protocol HomeViewModelProtocol {
    func numberOfSections() -> Int
    func numberOfItemsInSection() -> Int
//    func cellViewModel(forIndexPath IndexPath: IndexPath) -> CollectionViewCellModelProtocol?
    func setIndex(setIndex: IndexPath) -> Int
}

class HomeViewModel : HomeViewModelProtocol {
    
    var categoryCellViewModel = CategoryCellViewModel()
  
    
    
    var phones : PhoneManager?
    
    func setIndex(setIndex: IndexPath) -> Int {
        1
    }
    
    func numberOfSections() -> Int {
        3
    }
    
    func numberOfItemsInSection() -> Int {
        //phones?.phonesArray.count ?? 0
        return 3
    }
    
//    func cellViewModel(forIndexPath IndexPath: IndexPath) -> CollectionViewCellModelProtocol? {
//        return nil
//    }
    
    
}
