
import Foundation

protocol DataStorageProtocol {
    var inCart : Bool? { get set }
    func getProductsCart() -> [ProductCart]
    func setProductsCart(_ array: [ProductCart])
   // func setProductCart(product: ProductCart)
    func getCountProducts() -> Int
   // func getProduct(at id: Int) -> ProductCart?
}

struct DataStorage: DataStorageProtocol {
    
    var inCart : Bool?
    
    func getProductsCart() -> [ProductCart] {
        guard let data = UserDefaults.standard.object(forKey: NameKeyUserDefaults.devices.rawValue) as? Data,
              let array = try? PropertyListDecoder().decode([ProductCart].self, from: data)  else { return [] }
        
        return array
    }
    
    func setProductsCart(_ array: [ProductCart]) {
        let encodeData = try? PropertyListEncoder().encode(array)
        UserDefaults.standard.set(encodeData, forKey: NameKeyUserDefaults.devices.rawValue)
    }
    
//    func setProductCart(product: ProductCart) {
//        var products = getProductsCart()
//        if let index = products.firstIndex(where: { $0.id == product.id }) {
//            products[index] = product
//        } else {
//            products.append(product)
//        }
//        setProductsCart(products)
//    }
    
    func getCountProducts() -> Int {
        //let array = getProductsCart()
        //return array.reduce(0, { $0 + $1.count })
        return 2
    }
    
//    func getProduct(at id: Int) -> ProductCart? {
//        let array = getProductsCart()
//        guard let product = array.first(where: { id == $0.id }) else { return nil }
//        return product
//    }
    
    enum NameKeyUserDefaults: String {
        case devices
    }
}
