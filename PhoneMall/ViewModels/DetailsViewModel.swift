

import Foundation
import UIKit

// MARK: - DetailsViewModelProtocol
protocol DetailsViewModelProtocol {
    var reloadTableView: (() -> Void)? { get set }
    var coordinator : Coordinator { get }
    func getDetailsPhones()
    func getDetailsCellViewModel(at: IndexPath) -> DetailsCellModelProtocol?
}

// MARK: - DetailsViewModel

class DetailsViewModel : DetailsViewModelProtocol {
    
    // MARK: - Properties
    
    // Менеджер сети и хранилище данных
    let networkManager: Networking?
    var dataStorage: DataStorageProtocol?
    
    // Координатор для навигации
    var coordinator = Coordinator()
    
    // Данные для отображения на экране
    var productData : ProductDetailsData?

    // MARK: - Initialization
    init(networkManager: Networking?, dataStorage: DataStorageProtocol?) {
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
        networkManager?.getDetailsData(completion: { [weak self] data in
            switch data {
            case .success(let data):
                self?.productData = data
                self?.detailsModel = [self?.createCellModel(data: data)].compactMap { $0 }
                print("Телефоны в деталях: \(self?.detailsModel.first)")

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

}

