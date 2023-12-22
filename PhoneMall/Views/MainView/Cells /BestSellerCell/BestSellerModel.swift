

import Foundation

protocol BestSellerModelProtocol {
    var title: String? { get }
    var discountPrice : String? { get }
    var fullPrice : String? { get }
    var pictureUrlString : String? { get }
    var isFavorites: Bool? { get set }
}

class BestSellerModel: BestSellerModelProtocol {
    
    // Ключ для хранения информации об избранности в UserDefaults
    private let isFavoritesKey = "isFavoritesKey"
    
    // Свойства модели
    var title: String?
    var discountPrice: String?
    var fullPrice: String?
    var pictureUrlString: String?
    
    // Инициализатор модели
    init(title: String?, discountPrice: String?, fullPrice: String?, pictureUrlString: String?, isFavorites: Bool?) {
        self.title = title
        self.discountPrice = discountPrice
        self.fullPrice = fullPrice
        self.pictureUrlString = pictureUrlString
        self.isFavorites = isFavorites
        
        // Загрузка избранности из UserDefaults при создании объекта
        loadIsFavorites()
    }
    
    // Свойство для избранности, с автоматическим сохранением в UserDefaults
    var isFavorites: Bool? {
        didSet {
            saveIsFavorites()
        }
    }
    
    // Сохранение информации об избранности в UserDefaults
    func saveIsFavorites() {
        UserDefaults.standard.set(isFavorites, forKey: isFavoritesKey)
    }
    
    // Загрузка информации об избранности из UserDefaults
    func loadIsFavorites() {
        isFavorites = UserDefaults.standard.bool(forKey: isFavoritesKey)
    }
    
   
}

