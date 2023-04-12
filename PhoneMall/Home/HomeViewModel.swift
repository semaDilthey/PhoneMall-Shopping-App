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
}

class HomeViewModel {
    
}
