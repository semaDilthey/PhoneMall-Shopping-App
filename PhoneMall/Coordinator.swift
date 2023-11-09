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
    func showDetailVC() -> UIViewController
    func showCartVC() -> UIViewController
    func showHomeVC() -> UIViewController
    
}
class Coordinator: CoordinatorProtocol {
    
    var window : UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start(window: UIWindow)  {
        window.makeKeyAndVisible()
        window.rootViewController = showHomeVC()
        }

    
    func showDetailVC() -> UIViewController {
        let vc = DetailsVC()
        let navigationController = UINavigationController(rootViewController: vc)
//        let detailsViewModel = DetailsViewModel()
//        let detailsViewController = DetailsViewController(viewModel: detailsViewModel)

        return navigationController
    }
    
    func showCartVC() -> UIViewController {
        let vc = MyCartVC()
        let navigationController = UINavigationController(rootViewController: vc)
        
        return navigationController

    }
    
    func showHomeVC() -> UIViewController {
        let homeViewModel = HomeViewModel()
        let vc = HomeVC(homeViewModel: homeViewModel)
        let navigationController = UINavigationController(rootViewController: vc)
        
        return navigationController
        
    }
    
    
}
