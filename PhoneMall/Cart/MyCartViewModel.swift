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
    
    // MARK: - Properties
    var dataStorage : DataStorage?
    var networkManager : NetworkManager?
    
    var coordinator = Coordinator()

    var cartData : CartData?

    // MARK: - Initialization
    init(networkManager: NetworkManager?, dataStorage: DataStorage? ) {
        self.dataStorage = dataStorage
        self.networkManager = networkManager
    }
    
    // MARK: - Public Properties
    var reloadTableView: (() -> Void)?

    var cartPhonesModel = [MyCartCellModelProtocol]() {
        didSet {
            reloadTableView?()
        }
    }
    
    var cartPhonePricesTuple : (Double, Double) = (firstPrice : 0, secondPrice : 0)
    
    // MARK: - Public Methods

    func countTotal(string: String, at indexPath: IndexPath) {
        let stringWithoutDollarSign = string.replacingOccurrences(of: "$", with: "")
        
        if let intValue = Double(stringWithoutDollarSign) {
            if indexPath.row == 0 {
                self.cartPhonePricesTuple.0 = intValue
            }
            if indexPath.row == 1 {
                self.cartPhonePricesTuple.1 = intValue
            }
           
            
        } else {
            print("Невозможно преобразовать строку в Int")
        }
    }
    
    // MARK: - Buttons Methods

    func backButtonPressed(navController: UINavigationController, dataStorage: DataStorage) {
        coordinator.showHomeVC(controller: navController, dataStorage: dataStorage)
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
            networkManager?.getCartScreenData { [weak self] data in
                switch data {
                case .success(let data):
                    self?.cartData = data
                    self?.cartPhonesModel = data.basket.compactMap { basketData in
                        return self?.createCellModel(data: basketData)
                    }
//                    self?.cartPhonesModel = data.basket.map { self?.createCellModel(data: $0)}
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
    
    


