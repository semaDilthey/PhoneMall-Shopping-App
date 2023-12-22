

import Foundation
import UIKit

protocol MainViewModelProtocol {
    var dataStorage: DataStorageProtocol? { get set }
    // Навигация
    var coordinator : Coordinator { get }
    
    var categoryCellViewModel : CategoryCellViewModel { get set }
    var homeStoreCellViewModels : [HomeStoreCellModelProtocol] { get set }
    var bestSellerCellViewModels : [BestSellerModelProtocol] { get set }
    // Методы для получения данных
    func getBestSeller()
    func getHomeStore()
    func getCategories()
    
    // Замыкание для обновления таблицы
    var reloadTableView: (() -> Void)? { get set }
    
    // Методы для работы с таблицей
    func numberOfSections() -> Int
    func getNumberOfItemsInSection(in section: Int) -> Int

    func getBestCellViewModel(at indexPath: IndexPath) -> BestSellerModelProtocol
    func getHomeCellViewModel(at indexPath: IndexPath) -> HomeStoreCellModelProtocol?
    
}

// MARK: - MainViewModel

class MainViewModel: MainViewModelProtocol {
    
    // MARK: - Properties
    
    // Менеджер сети и хранилище данных
    let networkManager: Networking?
    var dataStorage: DataStorageProtocol?
    
    // Координатор для навигации
    var coordinator = Coordinator()
    
    // Данные для отображения на экране
    private var homeData: HomeData?
  
    // MARK: - Initialization
    
    init(networkManager: Networking?, dataStorage: DataStorageProtocol?) {
        self.networkManager = networkManager
        self.dataStorage = dataStorage
    }
    
    // MARK: - Public Properties
    
    // Замыкание для обновления таблицы при изменении соответствующих данных
    var reloadTableView: (() -> Void)?
    
    // Модели для разделов таблицы
    var categoryCellViewModel = CategoryCellViewModel() {
        didSet {
            reloadTableView?()
        }
    }
    
    var homeStoreCellViewModels = [HomeStoreCellModelProtocol]() {
        didSet {
            reloadTableView?()
        }
    }
    
    var bestSellerCellViewModels = [BestSellerModelProtocol]() {
        didSet {
            reloadTableView?()
        }
    }
    
    // MARK: - Public Methods
    
    // Получение данных о категориях (пока пустая реализация)
    func getCategories() {
        // TODO: Implement
    }
    
    // Получение данных для раздела "Домашний магазин"
    func getHomeStore() {
        networkManager?.getHomeData(completion: { [weak self] result in
            self?.handleDataResult(result, for: .homeStore)
        })
    }
    
    // Получение данных для раздела "Лучшие продажи"
    func getBestSeller() {
        networkManager?.getHomeData(completion: { [weak self] result in
            self?.handleDataResult(result, for: .bestSeller)
        })
    }
    
    // MARK: - Private Methods
    
    // Обработка данных, полученных из сети
    private func handleDataResult(_ result: Result<HomeData, Error>, for section: HomeSection) {
        switch result {
        case .success(let data):
            homeData = data
            switch section {
            case .homeStore:
                homeStoreCellViewModels = data.homeStore.map { createHomeStoreCellModel(data: $0) }
            case .bestSeller:
                bestSellerCellViewModels = data.bestSeller.map { createBestSellerCellModel(data: $0) }
            }
        case .failure(let error):
            print("\(error)")
        }
    }
    
    // Создание модели ячейки "Лучшие продажи"
    private func createBestSellerCellModel(data: BestSellerItem) -> BestSellerModelProtocol {
        let title = data.title
        let picture = data.picture
        let discountPrice = String(data.discountPrice) + "$"
        let fullPrice = String(data.priceWithoutDiscount) + "$"
        let isFavorites = data.isFavorites
        return BestSellerModel(title: title, discountPrice: discountPrice, fullPrice: fullPrice, pictureUrlString: picture, isFavorites: isFavorites)
    }
    
    // Создание модели ячейки "Домашний магазин"
    private func createHomeStoreCellModel(data: HomeStoreItem) -> HomeStoreCellModelProtocol {
        let title = data.title
        let subtitle = data.subtitle
        let picture = data.picture
        return HomeStoreCellModel(title: title, subtitle: subtitle, picture: picture)
    }
    
    // Получение модели для конкретной ячейки "Лучшие продажи"
    func getBestCellViewModel(at indexPath: IndexPath) -> BestSellerModelProtocol {
        return bestSellerCellViewModels[indexPath.row]
    }
    
    // Получение модели для конкретной ячейки "Домашний магазин"
    func getHomeCellViewModel(at indexPath: IndexPath) -> HomeStoreCellModelProtocol? {
        guard indexPath.row < homeStoreCellViewModels.count else { return nil }
        return homeStoreCellViewModels[indexPath.row]
    }
    
    // Количество секций в таблице
    func numberOfSections() -> Int {
        return 3
    }
    
    // Количество элементов в одной секции (пока временная реализация)
    func getNumberOfItemsInSection(in section: Int) -> Int {
        switch section {
        case 0 :
            return categoryCellViewModel.numberOfItemsInSection()
        case 1 :
            return homeStoreCellViewModels.count
        case 2 :
            return bestSellerCellViewModels.count
        default :
            return 0
        }
    }
}

enum HomeSection {
    case homeStore
    case bestSeller
}
