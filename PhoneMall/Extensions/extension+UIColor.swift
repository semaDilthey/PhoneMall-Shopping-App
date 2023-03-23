
// Extension для стандартного ЮАЙ колороа, добавляем свои цвета штоб было проще вызывать через UIColor.customOrange или типа того
import UIKit

extension UIColor {
    static var customOrange : UIColor {
        UIColor(named: "customOrange")!
    }
    
    static var customDarkBlue = UIColor(named: "customDarkBlue")
    static var snowyWhite = UIColor(named: "snowyWhite")
}
