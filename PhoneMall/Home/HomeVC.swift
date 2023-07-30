

import Foundation
import UIKit
import SwiftUI
//

class HomeVC : UICollectionViewController {
    
    var viewModel = {
        HomeViewModel()
    }()
    
    let categoryViewModel = CategoryCellViewModel()
    
    func initViewModel() {
        viewModel.getBestSeller()
        
        viewModel.getHomeStore()
        
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
    }
  

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationController()
        //self.collectionView.reloadData()
        initViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Скрытие navigationBar только на этом экране
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Восстановление отображения navigationBar при переходе с этого экрана
        navigationController?.setNavigationBarHidden(false, animated: false)
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
                
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80)), elementKind: HeaderSelectCategory.headerID, alignment: .top)]
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
        case 1 : return viewModel.homeStoreCellViewModels.count
        default : return viewModel.bestSellerCellViewModels.count
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
//
            let cellVM = viewModel.getHomeCellViewModel(at: indexPath)
            cell.cellViewModel = cellVM
            if indexPath.row == 1 {
                cell.phoneTitleLabel.text = ""
            }
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestSellerCell.identifire, for: indexPath) as! BestSellerCell
                    cell.layer.cornerRadius = 15
                    cell.clipsToBounds = true
                    cell.backgroundColor = .white
            let cellVM = viewModel.getBestCellViewModel(at: indexPath)
            cell.cellViewModel = cellVM
            cell.updateFavoritesUI()
            if indexPath.row == 3 {
                cell.image.image = UIImage(named: "homeStoreMotorola")
            }
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifire, for: indexPath) as! CategoryCell
            let cellViewModel = categoryViewModel
            cell.set(viewModel: cellViewModel, indexPath: indexPath)
            
            return cell
        }
    }

    
    
    // What will happen on click
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifire, for: indexPath) as! CategoryCell
//        let sectins = indexPath.section
//        if sectins == 0{
//            switch indexPath.row {
//            case 0: cell.view.backgroundColor = .purple
//            default:
//                cell.view.backgroundColor = .customOrange
//            }
//        }
        let vc = DetailsVC()
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
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderSelectCategory.headerID, for: indexPath) as! HeaderSelectCategory
            header.backgroundColor = .clear
            header.delegate = self
            return header
        default:
            fatalError("Unexpected element kind: \(kind)")
    }
    
    }
}

extension HomeVC : ReusableViewDelegate {
    func didTapButton() {
        let newVC = FilterViewController()
        present(newVC, animated: true, completion: nil)
    }
    
    
}


//struct ViewControllerProvider : PreviewProvider {
//    static var previews: some View {
//        HomeVC().showPreview()
//    }
//}
