//
//  DetailsViewModel.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 13.07.2023.
//

import Foundation

protocol DetailsViewModelProtocol {
    
    var reloadTableView: (() -> Void)? { get set }
    
    func getDetailsPhones()
    
    func getDetailsCellViewModel(at: IndexPath) -> DetailsCellModelProtocol?
}

class DetailsViewModel : DetailsViewModelProtocol {
    
    var data : ProductDetailsData?
    
    var networking: NetworkManager?
    
    var detailsModel = [DetailsCellModelProtocol]() {
        didSet {
            reloadTableView?()
        }
    }

    var reloadTableView: (() -> Void)?
    
    func getDetailsPhones() {
        networking?.getDetailsScreenData(completion: { [weak self] data in
            switch data {
            case .success(let data):
                self?.data = data
                var arr = [DetailsCellModelProtocol]()
                arr.append(self?.createCellModel(data: data) as! DetailsCellModelProtocol)
                self?.detailsModel = arr
            case .failure(let error):
                print("Error is: \(error)")
            }
        })
    }
    
    func createCellModel(data: ProductDetailsData) -> DetailsCellModelProtocol? {
        for image in data.images {
            return DetailsCellModel(images: image)
        }
        return nil
    }
    
    func getDetailsCellViewModel(at indexPath: IndexPath) -> DetailsCellModelProtocol? {
        guard indexPath.row < detailsModel.count else { return nil }
        return detailsModel[indexPath.item]
    }
    
}
