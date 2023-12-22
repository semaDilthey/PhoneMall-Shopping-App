

import Foundation
import UIKit

protocol CartViewModelProtocol {
    func getCartPhones()
    func getMyCartCellViewModel(at: IndexPath) -> MyCartCellModelProtocol?
    func createCellModel(data: BasketCartData) -> MyCartCellModelProtocol?
}


class CartViewModel {
    
    // MARK: - Properties
    var dataStorage : DataStorageProtocol?
    var networkManager : Networking?
    
    var coordinator = Coordinator()

    var cartData : CartData?

    // MARK: - Initialization
    init(networkManager: Networking?, dataStorage: DataStorageProtocol? ) {
        self.dataStorage = dataStorage
        self.networkManager = networkManager
    }
    
    //MARK: - Networking
        // 2 Получаем телефоны из интернета и запихиваем их в модель
    func getCartPhones() {
        networkManager?.getCartData { [weak self] data in
            switch data {
            case .success(let data):
                self?.cartData = data
                self?.cartPhonesModel = data.basket.compactMap { basketData in
                    return self?.createCellModel(data: basketData)
                }
            case .failure(let error):
                print(error)
            }
        }
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
    
    func deleteTapped(cell: MyCartCell, tableView: UITableView) {
        if let indexPath = tableView.indexPath(for: cell) {
            self.cartPhonesModel.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
    

//MARK: - MyCartViewModelProtocol
    extension CartViewModel : CartViewModelProtocol {
        
        // 1 создаем модель для корзины
        func createCellModel(data: BasketCartData) -> MyCartCellModelProtocol? {
            let picture = data.images
            let title = data.title
            let price = data.price
            return MyCartCellModel(title: title, picture: picture, price: price)
        }
        
        
        // 3 Получаем нужную модель для таблицы в ячейках
        func getMyCartCellViewModel(at indexPath: IndexPath) -> MyCartCellModelProtocol? {
            guard indexPath.row < cartPhonesModel.count else { return nil }
            return cartPhonesModel[indexPath.row]
        }
        
        
   
        
}
    
    


