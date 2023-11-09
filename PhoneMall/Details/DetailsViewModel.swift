//
//  DetailsViewModel.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 13.07.2023.
//

import Foundation
import UIKit

protocol DetailsViewModelProtocol {
    var reloadTableView: (() -> Void)? { get set }
    func getDetailsPhones()
    func getDetailsCellViewModel(at: IndexPath) -> DetailsCellModelProtocol?
    func backButtonPressed(navController: UINavigationController)
}


class DetailsViewModel : DetailsViewModelProtocol {
    
    var data : ProductDetailsData?
    
    var networking: NetworkManager? = NetworkManager()
    
    var detailsModel = [DetailsCellModelProtocol]() {
        didSet {
            reloadTableView?()
        }
    }
    
    var modelForCart = [ModelForCartProtocol]() {
        didSet {
            reloadTableView?()
        }
    }
    
    var selectedIndexPath: IndexPath?

    var reloadTableView: (() -> Void)?
    
    func getDetailsPhones() {
        networking?.getDetailsScreenData(completion: { [weak self] data in
            switch data {
            case .success(let data):
                self?.data = data
                var modelDetails = [DetailsCellModelProtocol]()
                //var modelForCart = [ModelForCartProtocol]()
                
                    modelDetails.append(self?.createCellModel(data: data) as! DetailsCellModelProtocol)
                    self?.detailsModel = modelDetails

                   // modelForCart.append(self?.createModelForCart(data: data) as! ModelForCartProtocol)
                   // self?.modelForCart = modelForCart
            case .failure(let error):
                print("Error is: \(error)")
            }
        })
    }
    
    
    func getModelForCart(at indexPath: IndexPath) -> ModelForCartProtocol? {
        guard let selectedIndexPathRow = selectedIndexPath?.row else { return nil }
        if selectedIndexPathRow < modelForCart.count {
            return modelForCart[selectedIndexPathRow]
        } else {
            return nil
        }
    }
    
    func createCellModel(data: ProductDetailsData) -> DetailsCellModelProtocol? {
//        for image in data.images {
//            return DetailsCellModel(images: image)
//        }
        return DetailsCellModel(images: data.images, price: data.price, title: data.title)
    }
    
    func getDetailsCellViewModel(at indexPath: IndexPath) -> DetailsCellModelProtocol? {
        guard indexPath.row < detailsModel.count else { return nil }
        return detailsModel[indexPath.row]
    }
    
    func createModelForCart(model: DetailsCellModel) -> MyCartCellModel {
        let title = model.title!
        let picture = model.images?.first
        let price = model.price!
        return MyCartCellModel(title: title, picture: picture!, price: price)
    }
    
    func backButtonPressed(navController: UINavigationController) {
        navController.popViewController(animated: true)
    }
    

}

