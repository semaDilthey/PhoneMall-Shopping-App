

import Foundation
import UIKit

protocol CoordinatorProtocol: AnyObject {
    func start(window: UIWindow)
    func showDetailVC(navController: UINavigationController?, dataStorage: DataStorageProtocol)
    func showCartVC(navController: UINavigationController?, dataStorage: DataStorageProtocol)
    func showHomeVC(navController: UINavigationController?, dataStorage: DataStorageProtocol)
    
}
class Coordinator: CoordinatorProtocol {
    
    func start(window: UIWindow)  {
        let homeViewModel = MainViewModel(networkManager: NetworkManager(), dataStorage: DataStorage())
        let vc = MainViewController(viewModel: homeViewModel)
        let navigationController = UINavigationController(rootViewController: vc)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        }
    
    
    func showDetailVC(navController: UINavigationController?, dataStorage: DataStorageProtocol){
        guard let navController else { return }
        let viewModel = DetailsViewModel(networkManager: NetworkManager(), dataStorage: dataStorage)
        let vc = DetailsViewController(viewModel: viewModel)
        setViewController(controller: navController, with: [vc])
    }
    
    func showCartVC(navController: UINavigationController?, dataStorage: DataStorageProtocol) {
        guard let navController else { return }
        let cartViewModel = CartViewModel(networkManager: NetworkManager(), dataStorage: dataStorage)
        let vc = CartViewController(viewModel: cartViewModel)
        setViewController(controller: navController, with: [vc])
    }
    
    
    func showHomeVC(navController: UINavigationController?, dataStorage: DataStorageProtocol) {
        guard let navController else { return }
        let homeViewModel = MainViewModel(networkManager: NetworkManager(), dataStorage: dataStorage)
        let vc = MainViewController(viewModel: homeViewModel)
        setViewController(controller: navController, with: [vc], animated: true)
    }
    

    private func setViewController(controller: UINavigationController, with viewControllers: [UIViewController], animated: Bool = true) {
            var vcArray = controller.viewControllers
            vcArray.removeAll()
            vcArray.append(contentsOf: viewControllers)

            controller.setViewControllers(vcArray, animated: animated)
        }
}
