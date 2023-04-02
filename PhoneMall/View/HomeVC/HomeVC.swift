

import Foundation
import UIKit
import SwiftUI
//

class HomeVC : UICollectionViewController{

    
   // var phonesArray = [PhoneData]()

    
    let headerID = "HeaderID"
    static let categoryHeaderId = "CategoryHeaderID"
    
    private let cellId = "CellId"
    
    //MARK: - ViewDidLoad, надо рефакторить
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor(named: "snowyWhite")
        navigationItem.title = "Select category"
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId) // рег ячейку
        collectionView.register(CustomCellSection1.self, forCellWithReuseIdentifier: CustomCellSection1.identifire)
        collectionView.register(CustomCellSection2.self, forCellWithReuseIdentifier: CustomCellSection2.identifire)
        collectionView.register(CustomCellSection3.self, forCellWithReuseIdentifier: CustomCellSection3.identifire)
        collectionView.register(Header.self, forSupplementaryViewOfKind: HomeVC.categoryHeaderId, withReuseIdentifier: headerID) // рег заголовок
        //performRequest(with: phoneURL)
//        getJSON(with: phoneURL)
        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationItem.hidesBackButton = true
    }
    
    init(){
        //MARK: - init comp layout
        super.init(collectionViewLayout: HomeVC.createLayout())
    }
    
    
    
    
    //MARK: - NETWORKING
//
//    let phoneURL = "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175"
//
//     func getJSON(with urlString : String) { // функция выполяющая запрос  через URLSession
//        guard let url = URL(string: urlString) else {
//                fatalError("guard URL failed")
//            }
//        URLSession.shared.dataTask(with: url) {  data, response, error in
//            if let data = data {
//                guard let phone = try? JSONDecoder().decode(PhoneData.self, from: data) else {
//                    fatalError("Something wrong with JSON Decoder, code: \(error!)")
//                }
//                self.phonesArray.append(phone)
//                print(self.phonesArray[0].bestSeller[0].discountPrice)
//            }
//        }
//        .resume()
//    }
    
    //MARK: - Создает композишен лейаут
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionNumber, evf in
    // первый ряд
            if sectionNumber == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.25), heightDimension: .estimated(120))) //item берет размеры от group. A group уже от view
                item.contentInsets.trailing = 11.5
                item.contentInsets.leading = 11.5
                item.contentInsets.bottom = 5
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
            return section
                
            } else {
                // второй ряд
            if sectionNumber == 1 {
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))) //item берет размеры от group. A group уже от view
                item.contentInsets.trailing = 2
                item.contentInsets.leading = 2
                item.contentInsets.bottom = 4
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .paging
            return section
                
            } else {
                // третий ряд
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(4/9))) //item берет размеры от group. A group уже от view
                    item.contentInsets.trailing = 16
                    item.contentInsets.leading = 16
                    item.contentInsets.bottom = 10
                    item.contentInsets.top = 10
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500)), subitems: [item])
                    let section = NSCollectionLayoutSection(group: group)
               
                // втыкаем заголовок для второго ряда
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: categoryHeaderId, alignment: .top)]
                    return section
                }
         }
     }
  }
    
    //MARK: - создает какой-то реюзабл вью
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath)
        header.backgroundColor = .clear
        return header
    }
    
    //MARK: - количество секций
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    //MARK: - колиечество ячеек в секции
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        } else {
        if section == 1 {
            return 3
        } else {
            return 4
        }
    }
}
    //MARK: - создает ячейку
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
// ячейки в 0 секции
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCellSection1.identifire, for: indexPath) as! CustomCellSection1
            cell.clipsToBounds = true
            //cell.layer.cornerRadius = cell.frame.width/2
            if indexPath.row == 0 {
                cell.image.image = UIImage(named: "phonesCircle")
                cell.label.text = "Phones"
                cell.label.textColor = UIColor(named: "customOrange")
                cell.view.backgroundColor = UIColor(named: "customOrange")
                //cell.view.backgroundColor = UIColor(named: "customOrange")
            } else if indexPath.row == 1 {
                cell.image.image = UIImage(named: "computerCircle")
                cell.label.text = "Computer"
                //cell.view.backgroundColor = .white
            } else if indexPath.row == 2 {
                cell.image.image = UIImage(named: "healthCircle")
                cell.label.text = "Health"
                //cell.view.backgroundColor = .white
            } else if indexPath.row == 3 {
                cell.image.image = UIImage(named: "booksCircle")
                cell.label.text = "Books"
                //cell.view.backgroundColor = .white
            }
            return cell
            // ячейки в 1 секции
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCellSection2.identifire, for: indexPath) as! CustomCellSection2
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
            //ячейки во 2 секции
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCellSection3.identifire, for: indexPath) as! CustomCellSection3
            cell.layer.cornerRadius = 15
            cell.clipsToBounds = true
            cell.backgroundColor = .white
            // shadows - не работает в данный момент
            cell.layer.shadowRadius = 2
            cell.layer.shadowOffset = CGSize(width: 0, height: 3)
            cell.layer.shadowOpacity = 0.25
            cell.layer.shadowColor = UIColor.black.cgColor
            if indexPath.row == 0 {
                cell.image.image = EasyHomeStoreData.picture[1]
                cell.discountPriceLabel.text = EasyHomeStoreData.discountPrice[1] + "$"
                cell.nameLabel.text = EasyHomeStoreData.titles[1]
                cell.priceLabel.text = EasyHomeStoreData.priceWithoutDiscount[1] + "$"
            } else if indexPath.row == 1 {
                cell.image.image = EasyHomeStoreData.picture[0]
                cell.discountPriceLabel.text = EasyHomeStoreData.discountPrice[0] + "$"
                cell.nameLabel.text = EasyHomeStoreData.titles[0]
                cell.priceLabel.text = EasyHomeStoreData.priceWithoutDiscount[0] + "$"
            } else if indexPath.row == 2 {
                cell.image.image = EasyHomeStoreData.picture[2]
                cell.discountPriceLabel.text = EasyHomeStoreData.discountPrice[2] + "$"
                cell.nameLabel.text = EasyHomeStoreData.titles[2]
                cell.priceLabel.text = EasyHomeStoreData.priceWithoutDiscount[2] + "$"
            } else {
                cell.image.image = EasyHomeStoreData.picture[3]
                cell.discountPriceLabel.text = EasyHomeStoreData.discountPrice[3] + "$"
                cell.nameLabel.text = EasyHomeStoreData.titles[3]
                cell.priceLabel.text = EasyHomeStoreData.priceWithoutDiscount[3] + "$"
            }
            return cell
        }
        
    }
    
    //MARK: - чо будет по клику на ячейку
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = UIViewController()
//        print("This cell #\(indexPath.row) located in section #\(indexPath.section)")
//        vc.view.backgroundColor = indexPath.section == 0 ? .yellow : .systemGray
//        navigationController?.pushViewController(vc, animated: true)
        
        let vc = ProductDetailsVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// класс для кастомного хедера
class Header : UICollectionReusableView {
    
    private let label : UILabel = {
        let label = UILabel()
        label.text = "Best seller"
        label.textColor = .black
        label.font = UIFont(name: "DSLCLU+MarkPro-Heavy", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let button : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(button)
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
      
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//struct ViewControllerProvider : PreviewProvider {
//    static var previews: some View {
//        HomeVC().showPreview()
//    
//    }
//}
