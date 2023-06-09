

import Foundation
import UIKit
import SwiftUI
//

class HomeVC : UICollectionViewController {
    
    var viewModel = HomeViewModel()
    
    private var bestSellerCellViewModel : [BestSellerCellViewModel]?
  
    var phoneManager = PhoneManager()
    var data : HomeData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationController()
        self.collectionView.reloadData()
        aa()
        
    }
    
    let categoryViewModel = CategoryCellViewModel()
    
    func aa () {
        phoneManager.getHomeScreenData(completion: { [weak self] data in
            DispatchQueue.main.async {
            switch data {
            case .success(let data) :
                self?.data = data
                self?.collectionView.reloadData()
            case .failure(let error) :
                print("error")
            }
            }
        })
    }

    
    //MARK: - init comp layout
    init(){
        super.init(collectionViewLayout: HomeVC.createLayout())
    }
    
    //MARK: - Создает композишен лейаут
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionNumber, evf in
    // первый ряд
            if sectionNumber == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.25), heightDimension: .estimated(120))) //item берет размеры от group. A group уже от view
                
                item.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                             leading: 12,
                                                             bottom: 5,
                                                             trailing: 12)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: HeaderSelectCategory.headerID, alignment: .top)]
            return section
                
            } else {
                // второй ряд
            if sectionNumber == 1 {
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))) //item берет размеры от group. A group уже от view
                item.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                             leading: 12,
                                                             bottom: 4,
                                                             trailing: 12)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .paging
                
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)), elementKind: HeaderHotSales.headerID, alignment: .top)]
            return section
                
            } else {
                // третий ряд
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(4/9))) //item берет размеры от group. A group уже от view
            item.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                         leading: 12,
                                                         bottom: 10,
                                                         trailing: 12)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
           
            // втыкаем заголовок для второго ряда
            section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: HeaderBestSeller.headerID, alignment: .top)]
                return section
            }
         }
     }
  }
    
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var filterButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "filter"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(filtersButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func filtersButtonTapped() {
         print ("/n/n filterButton was tapped /n/n")
         let vc = MyCartVC()
        vc.modalPresentationStyle = .popover
         present(vc, animated: true)
     }
    
    func setupCollectionView() {
        collectionView.backgroundColor = UIColor(named: "snowyWhite")
        
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifire)
        collectionView.register(HomeStoreCell.self, forCellWithReuseIdentifier: HomeStoreCell.identifire)
        collectionView.register(BestSellerCell.self, forCellWithReuseIdentifier: BestSellerCell.identifire)
        // рег заголовок
        collectionView.register(HeaderBestSeller.self, forSupplementaryViewOfKind: HeaderBestSeller.headerID, withReuseIdentifier: HeaderBestSeller.headerID)
        collectionView.register(HeaderHotSales.self, forSupplementaryViewOfKind: HeaderHotSales.headerID, withReuseIdentifier: HeaderHotSales.headerID)
        collectionView.register(HeaderSelectCategory.self, forSupplementaryViewOfKind: HeaderSelectCategory.headerID, withReuseIdentifier: HeaderSelectCategory.headerID)
    }
    
    func setupNavigationController() {
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationController?.navigationBar.prefersLargeTitles = false
        let barButton = UIBarButtonItem(customView: filterButton)
        barButton.imageInsets = UIEdgeInsets(top: -15, left: 15, bottom: 0, right: 0)
        navigationItem.rightBarButtonItem = barButton
    }
    
}



//MARK: - Delegate, DataSource
extension HomeVC {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        switch section {
        case 0 : return viewModel.categoryCellViewModel.numberOfItemsInSection()
        case 1 : return 3
        default : return 4
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifire, for: indexPath) as! CategoryCell
            let cellViewModel = categoryViewModel
            cellViewModel.set(indexPath: indexPath)
            cell.set(viewModel: categoryViewModel, indexPath: indexPath)
            if indexPath.row == 0 {
                cell.view.backgroundColor = .customOrange
            }
            if indexPath.row == 2 {
                cell.view.backgroundColor = .white
            }
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeStoreCell.identifire, for: indexPath) as! HomeStoreCell
                       cell.clipsToBounds = true
                       cell.layer.cornerRadius = 15
                       cell.backgroundColor = .brown
                       // ячейка №0 в 1 секции
                       if indexPath.row == 0 {
                           cell.phoneTitleLabel.text! = EasyBestSellerData.titles[0]
                           cell.subtitleLabel.text = EasyBestSellerData.subtitle
                           cell.mainImage.image = EasyBestSellerData.picture[0]
            
                           //ячейка №1 в 1 секции
                       } else if indexPath.row == 1 {
                           cell.phoneTitleLabel.text! = EasyBestSellerData.titles[1]
                           cell.subtitleLabel.text = EasyBestSellerData.subtitle
                           cell.phoneTitleLabel.text = ""
                           cell.mainImage.image = EasyBestSellerData.picture[1]
                           //ячейка №2 в 1 секции
                       } else {
                           cell.phoneTitleLabel.text = EasyBestSellerData.titles[2]
                           cell.subtitleLabel.text = EasyBestSellerData.subtitle
                           cell.phoneTitleLabel.textColor = .black
                           cell.mainImage.image = EasyBestSellerData.picture[2]
                       }
                       return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestSellerCell.identifire, for: indexPath) as! BestSellerCell
                    cell.layer.cornerRadius = 15
                    cell.clipsToBounds = true
                    cell.backgroundColor = .white
            
            if let cellVM = bestSellerCellViewModel {
               // cellVM.set(indexPath: indexPath)
                cell.set(viewModel: cellVM[indexPath.row], indexPath: indexPath)
            }
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifire, for: indexPath) as! CategoryCell
            let cellViewModel = categoryViewModel
            cell.set(viewModel: cellViewModel, indexPath: indexPath)
            return cell
        }
    }
    
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//// ячейки в 0 секции
//        if indexPath.section == 0 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifire, for: indexPath) as! CategoryCell
//            cell.clipsToBounds = true
//            //cell.layer.cornerRadius = cell.frame.width/2
//            if indexPath.row == 0 {
//                cell.image.image = UIImage(named: "phonesCircle")
//                cell.label.text = "Phones"
//                cell.label.textColor = UIColor(named: "customOrange")
//                cell.view.backgroundColor = UIColor(named: "customOrange")
//                //cell.view.backgroundColor = UIColor(named: "customOrange")
//            } else if indexPath.row == 1 {
//                cell.image.image = UIImage(named: "computerCircle")
//                cell.label.text = "Computer"
//                //cell.view.backgroundColor = .white
//            } else if indexPath.row == 2 {
//                cell.image.image = UIImage(named: "healthCircle")
//                cell.label.text = "Health"
//                //cell.view.backgroundColor = .white
//            } else if indexPath.row == 3 {
//                cell.image.image = UIImage(named: "booksCircle")
//                cell.label.text = "Books"
//                //cell.view.backgroundColor = .white
//            }
//            return cell
//            // ячейки в 1 секции
//        } else if indexPath.section == 1 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeStoreCell.identifire, for: indexPath) as! HomeStoreCell
//            cell.clipsToBounds = true
//            cell.layer.cornerRadius = 15
//            cell.backgroundColor = .brown
//            // ячейка №0 в 1 секции
//            if indexPath.row == 0 {
//                cell.phoneTitleLabel.text! = EasyBestSellerData.titles[0]
//                cell.subtitleLabel.text = EasyBestSellerData.subtitle
//                cell.mainImage.image = EasyBestSellerData.picture[0]
//                //ячейка №1 в 1 секции
//            } else if indexPath.row == 1 {
//                cell.phoneTitleLabel.text! = EasyBestSellerData.titles[1]
//                cell.subtitleLabel.text = EasyBestSellerData.subtitle
//                cell.phoneTitleLabel.text = ""
//                cell.mainImage.image = EasyBestSellerData.picture[1]
//                //ячейка №2 в 1 секции
//            } else {
//                cell.phoneTitleLabel.text = EasyBestSellerData.titles[2]
//                cell.subtitleLabel.text = EasyBestSellerData.subtitle
//                cell.phoneTitleLabel.textColor = .black
//                cell.mainImage.image = EasyBestSellerData.picture[2]
//            }
//            return cell
//            //ячейки во 2 секции
//        } else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestSellerCell.identifire, for: indexPath) as! BestSellerCell
//            cell.layer.cornerRadius = 15
//            cell.clipsToBounds = true
//            cell.backgroundColor = .white
//            //cell.set(viewModel: bestSellerCellViewModel!)
//            if indexPath.row == 0 {
//                cell.image.image = EasyHomeStoreData.picture[1]
//                cell.discountPriceLabel.text = EasyHomeStoreData.discountPrice[1] + "$"
//                cell.nameLabel.text = EasyHomeStoreData.titles[1]
//                cell.priceLabel.text = EasyHomeStoreData.priceWithoutDiscount[1] + "$"
//            } else if indexPath.row == 1 {
//                cell.image.image = EasyHomeStoreData.picture[0]
//                cell.discountPriceLabel.text = EasyHomeStoreData.discountPrice[0] + "$"
//                cell.nameLabel.text = EasyHomeStoreData.titles[0]
//                cell.priceLabel.text = EasyHomeStoreData.priceWithoutDiscount[0] + "$"
//            } else if indexPath.row == 2 {
//                cell.image.image = EasyHomeStoreData.picture[2]
//                cell.discountPriceLabel.text = EasyHomeStoreData.discountPrice[2] + "$"
//                cell.nameLabel.text = EasyHomeStoreData.titles[2]
//                cell.priceLabel.text = EasyHomeStoreData.priceWithoutDiscount[2] + "$"
//            } else {
//                cell.image.image = EasyHomeStoreData.picture[3]
//                cell.discountPriceLabel.text = EasyHomeStoreData.discountPrice[3] + "$"
//                cell.nameLabel.text = EasyHomeStoreData.titles[3]
//                cell.priceLabel.text = EasyHomeStoreData.priceWithoutDiscount[3] + "$"
//            }
//            return cell
//        }
//
//    }

    
    
    // What will happen on click
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProductDetailsVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //reusable view
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case HeaderBestSeller.headerID:
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderBestSeller.headerID, for: indexPath)
        header.backgroundColor = .clear
        return header
        case HeaderHotSales.headerID:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderHotSales.headerID, for: indexPath)
            header.backgroundColor = .clear
            return header
        case HeaderSelectCategory.headerID:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderSelectCategory.headerID, for: indexPath)
            header.backgroundColor = .clear
            header.addSubview(filterButton)
            header.isUserInteractionEnabled = true
            filterButton.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -35).isActive = true
            filterButton.topAnchor.constraint(equalTo: header.topAnchor, constant: -20).isActive = true
            return header
        default:
            fatalError("Unexpected element kind: \(kind)")
    }
    
    }
}



//struct ViewControllerProvider : PreviewProvider {
//    static var previews: some View {
//        HomeVC().showPreview()
//    }
//}
