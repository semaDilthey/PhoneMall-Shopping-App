//
//  CartViewModel.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 28.06.2023.
//

import Foundation

protocol MyCartViewModelProtocol {
    
    var reloadTableView: (() -> Void)? { get set }
    
    func getCartPhones()
    
    func getMyCartCellViewModel(at: IndexPath) -> MyCartCellModelProtocol?
}

class MyCartViewModel: MyCartViewModelProtocol {
    
    var data : CartData?
    var networking = NetworkManager()
    
    var cartPhonesModel = [MyCartCellModelProtocol]() {
        didSet {
            reloadTableView?()
        }
    }
    
    var reloadTableView: (() -> Void)?
    
    func getCartPhones() {
        networking.getCartScreenData { [weak self] data in
            switch data {
            case .success(let data):
                //guard let basket = data.basket else { return }
                self?.data = data
                var arr = [MyCartCellModelProtocol]()
                for basketItem in data.basket {
                    if let cellModel = self?.createCellModel(data: basketItem) {
                        arr.append(cellModel)
                    }
                }
                self?.cartPhonesModel = arr
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getMyCartCellViewModel(at indexPath: IndexPath) -> MyCartCellModelProtocol? {
        guard indexPath.row < cartPhonesModel.count else { return nil }
        return cartPhonesModel[indexPath.row]
    }
    
    func createCellModel(data: BasketCartData) -> MyCartCellModelProtocol? {
        let picture = data.images
        let title = data.title
        let price = data.price
        
        return MyCartCellModel(title: title, picture: picture, price: price)
    }
    
    
}
