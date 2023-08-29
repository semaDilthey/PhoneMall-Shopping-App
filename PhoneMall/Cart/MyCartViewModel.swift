//
//  CartViewModel.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 28.06.2023.
//

import Foundation

protocol MyCartViewModelProtocol {
    func getCartPhones()
    func getMyCartCellViewModel(at: IndexPath) -> MyCartCellModelProtocol?
    func createCellModel(data: BasketCartData) -> MyCartCellModelProtocol?
}

protocol MyCartCellProtocol {
    func removeCell(at indexPath: IndexPath)
}


class MyCartViewModel: MyCartCellProtocol {
    
    var data : CartData?
    var networking = NetworkManager()
    
    var reloadTableView: (() -> Void)?

    var cartPhonesModel = [MyCartCellModelProtocol]() {
        didSet {
            reloadTableView?()
            counterUpdateHandler?(5)
        }
    }
    
    var totalPrice: String? = ""
    var counterUpdateHandler: ((Int) -> Void)?
    
    func removeCell(at indexPath: IndexPath) {
    }
    
    
    @objc func deleteRow(at indexPath: IndexPath) {
        cartPhonesModel.remove(at: indexPath.row)
    }
    
}
    
    
    
    















//MARK: - MyCartViewModelProtocol
    extension MyCartViewModel : MyCartViewModelProtocol {
        
        // 1 создаем модельку для корзины
        func createCellModel(data: BasketCartData) -> MyCartCellModelProtocol? {
            let picture = data.images
            let title = data.title
            let price = data.price
            
            return MyCartCellModel(title: title, picture: picture, price: price)
        }
        
            // 2 Получаем телефончики из интернета и запихиваем их в модельку
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
        
        
        // 3 Получаем нужную модельку для таблицы в ячейках
        func getMyCartCellViewModel(at indexPath: IndexPath) -> MyCartCellModelProtocol? {
            guard indexPath.row < cartPhonesModel.count else { return nil }
            return cartPhonesModel[indexPath.row]
        }
        
        
   
        
}
    
    


