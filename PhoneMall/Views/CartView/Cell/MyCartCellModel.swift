

import Foundation

protocol MyCartCellModelProtocol {
    
    var title : String? { get }
    var price : Int? { get set }
    var picture : String? { get }
    //var counter : String? { get }  // счетчик товара на +/-
    
}

class MyCartCellModel: MyCartCellModelProtocol {
    
    var title : String?
    
    var price : Int?
    
    var picture : String?
        
    init(title: String, picture: String, price: Int) {
        self.title = title
        self.picture = picture
        self.price = price
    }
    
}
