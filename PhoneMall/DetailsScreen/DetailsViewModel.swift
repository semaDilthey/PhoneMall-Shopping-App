

import Foundation
import UIKit

// MARK: - DetailsViewModelProtocol
protocol DetailsViewModelProtocol {
    var reloadTableView: (() -> Void)? { get set }
    func getDetailsPhones()
    func getDetailsCellViewModel(at: IndexPath) -> DetailsCellModelProtocol?
    func backButtonPressed(navController: UINavigationController, data: DataStorage)
    func cartButtonPressed(navController: UINavigationController, data: DataStorage)
}

// MARK: - DetailsViewModel

class DetailsViewModel : DetailsViewModelProtocol {
    
    // MARK: - Properties
    
    // Менеджер сети и хранилище данных
    let networkManager: NetworkManager?
    var dataStorage: DataStorage?
    
    // Координатор для навигации
    let coordinator = Coordinator()
    
    // Данные для отображения на экране
    var productData : ProductDetailsData?

    // MARK: - Initialization
    init(networkManager: NetworkManager?, dataStorage: DataStorage?) {
        self.networkManager = networkManager
        self.dataStorage = dataStorage
    }
    
    // MARK: - Public Properties
    var detailsModel = [DetailsCellModelProtocol]() {
        didSet {
            reloadTableView?()
        }
    }
    
    var reloadTableView: (() -> Void)?

    var selectedIndexPath: IndexPath?

    // MARK: - Public Methods
    func getDetailsPhones() {
        networkManager?.getDetailsScreenData(completion: { [weak self] data in
            switch data {
            case .success(let data):
                self?.productData = data
                self?.detailsModel = [self?.createCellModel(data: data)].compactMap { $0 }
            case .failure(let error):
                print("Error is: \(error)")
            }
        })
    }

    private func createCellModel(data: ProductDetailsData) -> DetailsCellModelProtocol? {
        return DetailsCellModel(images: data.images, price: data.price, title: data.title)
    }
    
    func getDetailsCellViewModel(at indexPath: IndexPath) -> DetailsCellModelProtocol? {
        guard indexPath.row < detailsModel.count else { return nil }
        return detailsModel[indexPath.row]
    }
    
    func backButtonPressed(navController: UINavigationController, data: DataStorage) {
        coordinator.showHomeVC(controller: navController, dataStorage: data)
    }
    
    func cartButtonPressed(navController: UINavigationController, data: DataStorage) {
        coordinator.showCartVC(controller: navController, dataStorage: data)
    }

}

