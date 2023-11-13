//
//  HomeViewModel.swift
//  PhoneMall
//
//

import Foundation
import UIKit

protocol HomeViewModelProtocol {
    func getBestSeller()
    func getHomeStore()
    func getCategories()
    
    var reloadTableView: (() -> Void)? { get set }
    func numberOfSections() -> Int
    
    var homeStoreCellViewModels : [HomeStoreCellModelProtocol] { get set }
    var bestSellerCellViewModels : [BestSellerModelProtocol] { get set }
    
    var categoryCellViewModel : CategoryCellViewModel { get set }
    
    func getBestCellViewModel(at indexPath: IndexPath) -> BestSellerModelProtocol
    func getHomeCellViewModel(at indexPath: IndexPath) -> HomeStoreCellModelProtocol?
    
    func goToDetailsController(navController: UINavigationController)
    func goToCartController(navController: UINavigationController)
}


class HomeViewModel : HomeViewModelProtocol {
    
    let coordinator = Coordinator()
    
    private var data : HomeData?
    private let networkManager : NetworkManager?
    private var dataStorage : DataStorage?
    
    init(networkManager : NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    var countAddedProductInCart: String? {
        let count = dataStorage?.getCountProducts()
        return count != 0  ? String(count ?? 0) : nil
    }

    var reloadTableView: (() -> Void)?
    
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
    
    func getCategories() {
        
    }
    
    func getHomeStore() {
        networkManager?.getHomeScreenData(completion: { [weak self] data in
            switch data {
            case .success(let data) :
                self?.data = data
                var arr = [HomeStoreCellModelProtocol]()
                for item in data.homeStore {
                    arr.append((self?.createHomeStoreCellModel(data: item))!)
                }
                self?.homeStoreCellViewModels = arr
            case .failure(let error):
                print("\(error)")
            }
        })
        
    }
    
    func getBestSeller() {
        networkManager?.getHomeScreenData(completion: { [weak self] data in
            switch data {
            case .success(let data) :
                self?.data = data
                var arr = [BestSellerModelProtocol]()
                for item in data.bestSeller {
                    arr.append((self?.createBestSellerCellModel(data: item))!)
                }
                self!.bestSellerCellViewModels = arr
            case .failure(let error):
                print("\(error)")
                }
        })
    }
    
    private func createBestSellerCellModel(data: BestSellerItem) -> BestSellerModelProtocol {
        let title = data.title
        let picture = data.picture
        let discountPrice = String(data.discountPrice) + "$"
        let fullPrice = String(data.priceWithoutDiscount) + "$"
        let isFavorites = data.isFavorites
        return BestSellerModel(title: title, discountPrice: discountPrice, fullPrice: fullPrice, pictureUrlString: picture, isFavorites: isFavorites)
    }
    
    private func createHomeStoreCellModel(data: HomeStoreItem) -> HomeStoreCellModelProtocol {
        let title = data.title
        let subtitle = data.subtitle
        let picture = data.picture
        
        return HomeStoreCellModel(title: title, subtitle: subtitle, picture: picture)
    }
    
    func getBestCellViewModel(at indexPath: IndexPath) -> BestSellerModelProtocol {
        return bestSellerCellViewModels[indexPath.row]
    }
    
    func getHomeCellViewModel(at indexPath: IndexPath) -> HomeStoreCellModelProtocol? {
        guard indexPath.row < homeStoreCellViewModels.count else { return nil }
        return homeStoreCellViewModels[indexPath.row]
    }
    
    func setIndex(setIndex: IndexPath) -> Int {
        1
    }
    
    func numberOfSections() -> Int {
        3
    }
    
    func numberOfItemsInSection() -> Int {
        //phones?.phonesArray.count ?? 0
        return 3
    }
    
    func goToDetailsController(navController: UINavigationController) {
        coordinator.showDetailVC(controller: navController)
    }
    
    func goToCartController(navController: UINavigationController) {
        coordinator.showCartVC(controller: navController)
    }
    
}
