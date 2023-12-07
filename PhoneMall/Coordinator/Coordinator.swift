

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
        let homeViewModel = MainViewModel(networkManager: NetworkManager(), dataStorage: DataStorage())
        let vc = MainViewController(viewModel: homeViewModel)
        let navigationController = UINavigationController(rootViewController: vc)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        }
    
    
    func showDetailVC(controller: UINavigationController, dataStorage: DataStorage){
        let viewModel = DetailsViewModel(networkManager: NetworkManager(), dataStorage: dataStorage)
        let vc = DetailsViewController(viewModel: viewModel)
        setViewController(controller: controller, with: [vc])
    }
    
    func showCartVC(controller: UINavigationController, dataStorage: DataStorage) {
        let cartViewModel = MyCartViewModel(networkManager: NetworkManager(), dataStorage: dataStorage)
        let vc = MyCartVC(viewModel: cartViewModel)
        setViewController(controller: controller, with: [vc])
    }
    
    
    func showHomeVC(controller: UINavigationController, dataStorage: DataStorage) {
        let homeViewModel = MainViewModel(networkManager: NetworkManager(), dataStorage: dataStorage)
        let vc = MainViewController(viewModel: homeViewModel)
        setViewController(controller: controller, with: [vc], animated: true)
    }
    

    private func setViewController(controller: UINavigationController, with viewControllers: [UIViewController], animated: Bool = true) {
            var vcArray = controller.viewControllers
            vcArray.removeAll()
            vcArray.append(contentsOf: viewControllers)

            controller.setViewControllers(vcArray, animated: animated)
        }
}
