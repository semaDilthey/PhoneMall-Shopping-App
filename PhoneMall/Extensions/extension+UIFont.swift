

import UIKit

extension UIFont {
    
    enum MarkProFontWeight: Int {
        case plain = 400
        case medium = 500
        case heavy = 800
        
        var nameFont: String {
            switch self {
            case .plain:
                return "DSLCLU+MarkPro"
            case .medium:
                return "DSLCLU+MarkPro-Medium"
            case .heavy:
                return "DSLCLU+MarkPro-Heavy"
            }
        }
    }
    
    static func markProFont(size fontSize: CGFloat, weight fontWeight: MarkProFontWeight) -> UIFont? {
        UIFont(name: fontWeight.nameFont, size: fontSize)
    }
}
