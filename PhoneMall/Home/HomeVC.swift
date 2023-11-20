

import Foundation
import UIKit
import SwiftUI


final class HomeVC : UICollectionViewController {
    
    // MARK: - Properties
    
    private var viewModel : HomeViewModel
    var localData: DataStorage?

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Скрытие navigationBar только на этом экране
        setupNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Восстановление отображения navigationBar при переходе с этого экрана
        restoreNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupRoundedFrames()
    }

    // MARK: - Initialization
    
    init(homeViewModel: HomeViewModel){
        self.viewModel = homeViewModel
        self.localData = homeViewModel.dataStorage
        super.init(collectionViewLayout: .init())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI Elements
    
    lazy var tabView : TabBarView = {
        let view = TabBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        view.bagButton.addTarget(self, action: #selector(openCart), for: .touchUpInside)
        return view
    }()
    
    private let countProductCartLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.backgroundColor = .red
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = label.frame.height / 2
        label.clipsToBounds = true
        return label
      }()
    
    @objc func openCart() {
        guard let navigationController = navigationController, let data = localData else { return }
        //guard let data = localData else { return }
        viewModel.goToCartController(navController: navigationController, dataStorage: data)
    }
   
}

// MARK: - Private Methods

private extension HomeVC {
    // to viewDidLoad
    func setupUI() {
            setupCollectionView()
            setupNavigationController()
            setupViews()
    }
    
    func setupCollectionView() {
          collectionView.collectionViewLayout = createCompositionalLayout()
          collectionView.backgroundColor = .snowyWhite
          
          collectionView.register(CategoryCell.self, 
                                  forCellWithReuseIdentifier: CategoryCell.identifire)
          collectionView.register(HomeStoreCell.self, 
                                  forCellWithReuseIdentifier: HomeStoreCell.identifire)
          collectionView.register(BestSellerCell.self, 
                                  forCellWithReuseIdentifier: BestSellerCell.identifire)
        
          // рег заголовок
          collectionView.register(HeaderBestSeller.self, 
                                  forSupplementaryViewOfKind: HeaderBestSeller.headerID, 
                                  withReuseIdentifier: HeaderBestSeller.headerID)
          collectionView.register(HeaderHotSales.self,
                                  forSupplementaryViewOfKind: HeaderHotSales.headerID, 
                                  withReuseIdentifier: HeaderHotSales.headerID)
          collectionView.register(HeaderSelectCategory.self,
                                  forSupplementaryViewOfKind: HeaderSelectCategory.headerID, 
                                  withReuseIdentifier: HeaderSelectCategory.headerID)
      }
    
    
    func setupNavigationController() {
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func  setupViews() {
        view.addSubview(tabView)
        tabView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 3).isActive = true
        tabView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -3).isActive = true
        tabView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        tabView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        tabView.addSubview(countProductCartLabel)
        countProductCartLabel.centerXAnchor.constraint(equalTo: tabView.bagButton.centerXAnchor, constant: 8).isActive = true
        countProductCartLabel.centerYAnchor.constraint(equalTo: tabView.bagButton.centerYAnchor, constant: -8).isActive = true
        countProductCartLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        countProductCartLabel.widthAnchor.constraint(equalTo: countProductCartLabel.heightAnchor).isActive = true
    }
    
    // to viewDidLoad
    func initViewModel() {
        viewModel.getBestSeller()
        viewModel.getHomeStore()
        setupViewModelCallbacks()
    }
    
    func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        updateCartCountVisibility()
    }

    func restoreNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setupRoundedFrames() {
        tabView.layer.cornerRadius = tabView.frame.height / 2
        tabView.clipsToBounds = true
        countProductCartLabel.layer.cornerRadius = countProductCartLabel.frame.height / 2
        countProductCartLabel.clipsToBounds = true
    }
    
    func setupViewModelCallbacks() {
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
        
    func updateCartCountVisibility() {
        countProductCartLabel.isHidden = viewModel.dataStorage?.inCart == nil

    }
}


//MARK: - Creating layout
private extension HomeVC {
    
    // MARK:  Constants
    
    enum SectionInsets {
        case first, second, third
        
        var value : NSDirectionalEdgeInsets {
            switch self {
            case .first : return NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
            case .second : return NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 4, trailing: 12)
            case .third : return NSDirectionalEdgeInsets(top: 10, leading: 12, bottom: 10, trailing: 12)
            }
        }
    }
    
    private var horizontalSpacing: CGFloat {
        12
    }
    private var verticalSpacing: CGFloat {
        5
    }
    
    // MARK:  Layout Creation

     func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
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
    
    //MARK:  LayoutItem&Group Creation
    // Функция создания layout item с передачей отступов
    func createLayoutItem(widthFraction: CGFloat, heightFraction: CGFloat, contentInsets: NSDirectionalEdgeInsets) -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(widthFraction), heightDimension: .fractionalHeight(heightFraction))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = contentInsets
        return item
    }
    // Функция создания layout group
    func createGroup(layoutSize: NSCollectionLayoutSize, subitems: [NSCollectionLayoutItem]) -> NSCollectionLayoutGroup {
        return NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitems: subitems)
        }
  
    //MARK: Section Creation
    
     func createFirstSection() -> NSCollectionLayoutSection {
         
         let item = createLayoutItem(widthFraction: 0.25, heightFraction: 1, contentInsets: SectionInsets.first.value)
         let group = createGroup(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)), subitems: [item])
         let section = NSCollectionLayoutSection(group: group)
         section.orthogonalScrollingBehavior = .continuous
         section.boundarySupplementaryItems = [createHeaderItem(height: 80, kind: HeaderSelectCategory.headerID)]
         return section
    }
    
     func createSecondSection() -> NSCollectionLayoutSection {
         
         let item = createLayoutItem(widthFraction: 1, heightFraction: 1, contentInsets: SectionInsets.second.value)
         let group = createGroup(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [item])
         let section = NSCollectionLayoutSection(group: group)
         section.orthogonalScrollingBehavior = .paging
         section.boundarySupplementaryItems = [createHeaderItem(height: 120, kind: HeaderHotSales.headerID)]
         return section
    }
    
     func createThirdSection() -> NSCollectionLayoutSection {
      
        let item = createLayoutItem(widthFraction: 0.5, heightFraction: 38/100, contentInsets: SectionInsets.third.value)
        let group = createGroup(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(600)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [createHeaderItem(height: 50, kind: HeaderBestSeller.headerID)]
        return section
    }
    
    // MARK:  Helper Methods

    func createHeaderItem(height: CGFloat, kind: String) -> NSCollectionLayoutBoundarySupplementaryItem {
        return .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(height)), elementKind: kind, alignment: .top)
    }
}


    

//MARK: - Delegate, DataSource

extension HomeVC {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        switch section {
            
        case 0 :
            return viewModel.categoryCellViewModel.numberOfItemsInSection()
            
        case 1 :
            return viewModel.homeStoreCellViewModels.count
            
        default :
            return viewModel.bestSellerCellViewModels.count
            
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
            
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifire, for: indexPath) as! CategoryCell
            let categoryCellViewModel = CategoryCellViewModel()
            categoryCellViewModel.set(indexPath: indexPath)
            cell.set(viewModel: categoryCellViewModel, indexPath: indexPath)
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeStoreCell.identifire, for: indexPath) as! HomeStoreCell
            let homeStoreCellViewModel = viewModel.getHomeCellViewModel(at: indexPath)
            cell.viewModel = homeStoreCellViewModel
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestSellerCell.identifire, for: indexPath) as! BestSellerCell
            let bestSellerCellViewModel = viewModel.getBestCellViewModel(at: indexPath)
            cell.viewModel = bestSellerCellViewModel
            return cell
            
        default:
            return CategoryCell()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch indexPath.section {
            
        case 0:
            if let categoryCell = cell as? CategoryCell {
                if indexPath.row == 0 {
                    categoryCell.view.backgroundColor = .customOrange
                    categoryCell.label.textColor = .customOrange
                    categoryCell.label.font = UIFont.markProFont(size: 12, weight: .heavy)
                } else {
                    categoryCell.view.backgroundColor = .white
                    categoryCell.label.textColor = .black
                    categoryCell.label.font = UIFont.markProFont(size: 12, weight: .plain)
                }
            }
            
        default:
            break
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
            if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell {
                cell.isSelected = true
            }
        } else {
            viewModel.goToDetailsController(navController: navigationController!, dataStorage: viewModel.dataStorage ?? DataStorage())
        }

        
    }
       
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
            if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell {
                cell.isSelected = false
            }
        }
    }
    
 
    //reusable view
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            
        case HeaderBestSeller.headerID:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, 
                                                                         withReuseIdentifier: HeaderBestSeller.headerID,
                                                                         for: indexPath)
            header.backgroundColor = .clear
            return header
            
        case HeaderHotSales.headerID:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, 
                                                                         withReuseIdentifier: HeaderHotSales.headerID,
                                                                         for: indexPath)
            header.backgroundColor = .clear
            return header
            
        case HeaderSelectCategory.headerID:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, 
                                                                         withReuseIdentifier: HeaderSelectCategory.headerID,
                                                                         for: indexPath) as! HeaderSelectCategory
            header.backgroundColor = .clear
            header.delegate = self
            return header
            
        default:
            assertionFailure("Unexpected element kind: \(kind)")
            return UICollectionReusableView()
    }
    
    }
}
//MARK: - ReusableViewDelegate

extension HomeVC : ReusableViewDelegate {
    func didTapFilterButton() {
        let sheetViewController = FilterViewController()
        if let sheet = sheetViewController.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        present(sheetViewController, animated: true)
    }
}






//struct ViewControllerProvider : PreviewProvider {
//    static var previews: some View {
//        HomeVC().showPreview()
//    }
//}
 
