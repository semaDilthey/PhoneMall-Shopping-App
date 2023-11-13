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
    func showDetailVC(controller: UINavigationController)
    func showCartVC(controller: UINavigationController)
    func showHomeVC(controller: UINavigationController)
    
}
class Coordinator: CoordinatorProtocol {
    
    func start(window: UIWindow)  {
        window.makeKeyAndVisible()
        let homeViewModel = HomeViewModel()
        let vc = HomeVC(homeViewModel: homeViewModel)
        let navigationController = UINavigationController(rootViewController: vc)
        window.rootViewController = navigationController

        }

    
    func showDetailVC(controller: UINavigationController){

        let vc = DetailsVC()
        var vcArray = controller.viewControllers
        print("Old : \(vcArray)")
        vcArray.removeAll()
        vcArray.append(vc)
        print("New : \(vcArray)")

        controller.setViewControllers(vcArray, animated: true)
    }
    
    func showCartVC(controller: UINavigationController) {
        
        let vc = MyCartVC()
        var vcArray = controller.viewControllers
        print("Old : \(vcArray)")
        vcArray.removeAll()
        vcArray.append(vc)
        print("New : \(vcArray)")

        controller.setViewControllers(vcArray, animated: true)

    }
    
    
    

    
    func showHomeVC(controller: UINavigationController) {
        let homeViewModel = HomeViewModel()
        let vc = HomeVC(homeViewModel: homeViewModel)
        var vcArray = controller.viewControllers
        print("Old : \(vcArray)")
        vcArray.removeAll()
        vcArray.append(vc)
        print("New : \(vcArray)")

        controller.setViewControllers(vcArray, animated: true)
        
        //controller.popViewController(animated: false)
        //controller.pushViewController(vc, animated: true)
        
    }
    
    
}
