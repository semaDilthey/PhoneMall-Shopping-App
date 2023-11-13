//
//  CartViewModel.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 28.06.2023.
//

import Foundation
import UIKit

protocol MyCartViewModelProtocol {
    func getCartPhones()
    func getMyCartCellViewModel(at: IndexPath) -> MyCartCellModelProtocol?
    func createCellModel(data: BasketCartData) -> MyCartCellModelProtocol?
}


class MyCartViewModel {
    
    var data : CartData?
    var networking = NetworkManager()
    
    var coordinator = Coordinator()
    
    var reloadTableView: (() -> Void)?

    var cartPhonesModel = [MyCartCellModelProtocol]() {
        didSet {
            reloadTableView?()
        }
    }
    
    // Получаем телефоны из Details сюда по нажатию на AddToCart
    var phonesInCart : [MyCartCellModelProtocol] = []
    
    @objc func deleteRow(at indexPath: IndexPath) {
        cartPhonesModel.remove(at: indexPath.row)
    }
        
    
    var tupleOfPrices : (Double, Double) = (firstPrice : 0, secondPrice : 0)
    
    func countTotal(string: String, at indexPath: IndexPath) {
        let stringWithoutDollarSign = string.replacingOccurrences(of: "$", with: "")
        
        if let intValue = Double(stringWithoutDollarSign) {
            if indexPath.row == 0 {
                self.tupleOfPrices.0 = intValue
            }
            if indexPath.row == 1 {
                self.tupleOfPrices.1 = intValue
            }
           
            
        } else {
            print("Невозможно преобразовать строку в Int")
        }
    }
    
    func backButtonPressed(navController: UINavigationController) {
        coordinator.showHomeVC(controller: navController)
    }
    
    func deleteTapped(cell: MyCartCell, tableView: UITableView) {
        if let indexPath = tableView.indexPath(for: cell) {
            self.cartPhonesModel.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
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
    
    


