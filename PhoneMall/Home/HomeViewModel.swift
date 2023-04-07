//
//  HomeViewModel.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 07.04.2023.
//

import Foundation

protocol HomeViewModelProtocol {
    func numberOfSections() -> Int
    func numberOfItemsInSection() -> Int
    func cellViewModel(forIndexPath IndexPath: IndexPath) -> CollectionViewCellModelProtocol?
}

class HomeViewModel {
    
}
