

import Foundation
import UIKit
import SwiftUI


final class HomeVC : UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationController()
        initViewModel()
        setupUI()
    }
    
    let homeViewModel = HomeViewModel()
    
    let categoryViewModel = CategoryCellViewModel()
    
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
    
    func initViewModel() {
        homeViewModel.getBestSeller()
        
        homeViewModel.getHomeStore()
        
        homeViewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
    }
    
    init(){
        super.init(collectionViewLayout: .init())
    }
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tabView = UITabView()
}



//MARK: - Delegate, DataSource
extension HomeVC {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return homeViewModel.numberOfSections()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        switch section {
        case 0 : return homeViewModel.categoryCellViewModel.numberOfItemsInSection()
        case 1 : return homeViewModel.homeStoreCellViewModels.count
        default : return homeViewModel.bestSellerCellViewModels.count
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
                cell.label.textColor = .customOrange
                cell.label.font = UIFont.markProFont(size: 12, weight: .heavy)
            } else {
                cell.view.backgroundColor = .white
                cell.label.textColor = .black
                cell.label.font = UIFont.markProFont(size: 12, weight: .plain)
            }
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeStoreCell.identifire, for: indexPath) as! HomeStoreCell
            let cellVM = homeViewModel.getHomeCellViewModel(at: indexPath)
            cell.cellViewModel = cellVM
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestSellerCell.identifire, for: indexPath) as! BestSellerCell
            let cellVM = homeViewModel.getBestCellViewModel(at: indexPath)
            cell.cellViewModel = cellVM
            cell.updateFavoritesUI()
        
            return cell
        default:
            return CategoryCell()
        }
    }
    
    // What will happen on click didSelectItemAt
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell {
                cell.changeCellColor(isSelected: true, cell: cell)
            }
        default :
            let vc = DetailsVC()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
       
    // didDeselectItemAt
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell {
                cell.changeCellColor(isSelected: false, cell: cell)

            }
        }
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
//MARK: - ReusableViewDelegate

extension HomeVC : ReusableViewDelegate {
    func didTapButton() {
        let sheetViewController = FilterViewController()
        if let sheet = sheetViewController.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        present(sheetViewController, animated: true)
    }
}


//MARK: - SetupUI, Constraits, Nav View
private extension HomeVC {
    
      func setupCollectionView() {
          
          collectionView.collectionViewLayout = createLayout()
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


//MARK: - Creating layout
private extension HomeVC {
     func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionNumber, evf ->
            NSCollectionLayoutSection? in
            switch sectionNumber {
            case 0: return self.createFirstSection()
            case 1: return self.createSecondSection()
            case 2: return self.createThirdSection()
            default: return self.createFirstSection()
            }
         }
     }
  
    //MARK: 1stSection
     func createFirstSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .absolute(120))
        let item = NSCollectionLayoutItem(layoutSize: itemSize) //item берет размеры от group. A group уже от view
        
         let horizontalSpacing : CGFloat = 12
         let verticalSpacing : CGFloat = 5
         
        item.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                     leading: horizontalSpacing,
                                                     bottom: verticalSpacing,
                                                     trailing: horizontalSpacing)
         
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80)), elementKind: HeaderSelectCategory.headerID, alignment: .top)]
        return section
    }
    
    //MARK: 2ndSection
     func createSecondSection() -> NSCollectionLayoutSection {
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
    }
    
    //MARK: 3rdSection
     func createThirdSection() -> NSCollectionLayoutSection {
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


extension HomeVC {
    
    func  setupUI() {
        
        view.addSubview(tabView)
        
        tabView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tabView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tabView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tabView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}

//struct ViewControllerProvider : PreviewProvider {
//    static var previews: some View {
//        HomeVC().showPreview()
//    }
//}
