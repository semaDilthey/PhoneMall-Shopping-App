//
//import Foundation
//import UIKit
//import SwiftUI
//
//class TabBarViewController: UITabBarController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .clear
//        setTabBarAppearance()
//        setupVCs()
//        self.tabBar.items?[0].title = ""
//        self.tabBar.items?[0].imageInsets = UIEdgeInsets(top: 60, left: 0, bottom: -60, right: 0)
//    }
//    //MARK: - Задаем вид кнопки для табБара и потом создаем сам табБар из первой функции
//    fileprivate func createNavController(for rootViewController: UIViewController, title: String? = "", image: UIImage? = nil) -> UIViewController {
//          let navController = UINavigationController(rootViewController: rootViewController)
//        navController.tabBarItem.title = ""
//          navController.tabBarItem.image = image
//          navController.navigationBar.prefersLargeTitles = true
//          rootViewController.navigationItem.title = ""
//
//          return navController
//      }
//
//    func setupVCs() {
//          viewControllers = [
//              createNavController(for: HomeVC(), image: UIImage(systemName: "magnifyingglass")!),
//              createNavController(for: ProductDetailsVC(), image: UIImage(systemName: "house")!),
//              createNavController(for: MyCartVC(), image: UIImage(systemName: "person")!)
//          ]
//      }
//
//    //MARK: - оформляем внешку табБара( скругляем углы )
//    private func setTabBarAppearance() {
//
//        let roundLayer = CAShapeLayer() //  с его помощью можем рисовать кривые безье, т.е. идеальный вариант для создания плавного сильноскругленного треугольника. ПОложение задается по оси Х и У соответсвенно (ширина и высота)
//        let positionOnX : CGFloat = 1
//        let positionOnY : CGFloat = 14
//        let width = tabBar.bounds.width - positionOnX*2 // ширина = Ширина нашего табБара минус отступы по бокам ( позиция от икса * 2)
//        let height = tabBar.bounds.height + positionOnY*2 // высота
//
//        let bezierPath = UIBezierPath( // рисуем саму фигуру через кривые Безье. y - расстояние от верха экрана до верхней границы табБара
//            roundedRect: CGRect(
//                x: positionOnX,
//                y: tabBar.bounds.minY + positionOnY, //  y - расстояние от верха экрана до верхней границы табБара
//                width: width,
//                height: height
//            ),
//            cornerRadius: height / 2
//        )
//        roundLayer.path = bezierPath.cgPath
//        tabBar.layer.insertSublayer(roundLayer, at: 0) // помещаем созданный слой на табБар по индексу 0
//
//        tabBar.itemWidth = width/5 // задаем ширину айтемам
//        tabBar.itemPositioning = .centered // позиционируем айтемы по центру
//
//        tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        roundLayer.fillColor = UIColor.customDarkBlue?.cgColor // цвет для самой формы
//        tabBar.tintColor = .customOrange // цвет для выделенной ячейки
//        tabBar.unselectedItemTintColor = .white //цвет для невыделенных
//
//
//        // ------------------------ убираем дебильный фон таббара таким способом
//        tabBar.backgroundImage = UIImage()
//          tabBar.backgroundColor = .clear
//          tabBar.shadowImage = UIImage()
//
//        //------------------------------
//    }
//}
//


//struct ViewControllerProvider : PreviewProvider {
//    static var previews: some View {
//
//        TabBarViewController().showPreview()
//    }
//}
