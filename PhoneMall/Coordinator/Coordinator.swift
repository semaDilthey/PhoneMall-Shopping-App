//
//  Coordinator.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 09.11.2023.
//

import Foundation
import UIKit

protocol CoordinatorProtocol: AnyObject {
    func start(window: UIWindow)
    func showDetailVC(controller: UINavigationController, dataStorage: DataStorage)
    func showCartVC(controller: UINavigationController, dataStorage: DataStorage)
    func showHomeVC(controller: UINavigationController, dataStorage: DataStorage)
    
}
class Coordinator: CoordinatorProtocol {
    
    func start(window: UIWindow)  {
        let homeViewModel = HomeViewModel(networkManager: NetworkManager(), dataStorage: DataStorage())
        let vc = HomeVC(homeViewModel: homeViewModel)
        let navigationController = UINavigationController(rootViewController: vc)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        }
    
    
    func showDetailVC(controller: UINavigationController, dataStorage: DataStorage){
        let viewModel = DetailsViewModel(networkManager: NetworkManager(), dataStorage: dataStorage)
        let vc = DetailsVC(viewModel: viewModel)
        setViewController(controller: controller, with: [vc])
    }
    
    func showCartVC(controller: UINavigationController, dataStorage: DataStorage) {
        let cartViewModel = MyCartViewModel(networkManager: NetworkManager(), dataStorage: dataStorage)
        let vc = MyCartVC(viewModel: cartViewModel)
        setViewController(controller: controller, with: [vc])
    }
    
    
    func showHomeVC(controller: UINavigationController, dataStorage: DataStorage) {
        let homeViewModel = HomeViewModel(networkManager: NetworkManager(), dataStorage: dataStorage)
        let vc = HomeVC(homeViewModel: homeViewModel)
        setViewController(controller: controller, with: [vc], animated: true)
    }
    

    private func setViewController(controller: UINavigationController, with viewControllers: [UIViewController], animated: Bool = true) {
            var vcArray = controller.viewControllers
            vcArray.removeAll()
            vcArray.append(contentsOf: viewControllers)

            controller.setViewControllers(vcArray, animated: animated)
        }
}
