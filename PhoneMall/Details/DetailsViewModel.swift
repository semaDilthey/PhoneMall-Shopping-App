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


protocol DetailsToMyCartDelegate: AnyObject {
    func sendModelToCart(model: ModelForCartProtocol, at indexPath: IndexPath) -> MyCartCellModelProtocol?
      
}



class DetailsViewModel : DetailsViewModelProtocol {
    
    var delegate : DetailsToMyCartDelegate?
    
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
        print("aaaa")
        networking?.getDetailsScreenData(completion: { [weak self] data in
            print("aaa")
            switch data {
            case .success(let data):
                self?.data = data
                var modelDetails = [DetailsCellModelProtocol]()
                var modelForCart = [ModelForCartProtocol]()
                
                    modelDetails.append(self?.createCellModel(data: data) as! DetailsCellModelProtocol)
                    self?.detailsModel = modelDetails

                   // modelForCart.append(self?.createModelForCart(data: data) as! ModelForCartProtocol)
                   // self?.modelForCart = modelForCart
            case .failure(let error):
                print("Error is: \(error)")
            }
        })
    }
    
    // создаем модель которую будем передавать в cart
//    func createModelForCart(data: ProductDetailsData) -> ModelForCartProtocol? {
//        let price = String(data.price)
//        let title = data.title
//        let picture : String
//        for image in data.images {
//            picture = image
//        }
//        return ModelForCart(price: price, title: title, picture: picture)
//    }
    
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
        return DetailsCellModel(images: data.images)
    }
    
    func getDetailsCellViewModel(at indexPath: IndexPath) -> DetailsCellModelProtocol? {
        guard indexPath.row < detailsModel.count else { return nil }
        return detailsModel[indexPath.row]
    }
    
}
