
import Foundation
import UIKit

extension UITabBarController {
   func addLabelAtTabBarItemIndex(tabIndex: Int, value: Any) {
        //let tabBarItemCount = CGFloat(self.tabBar.items!.count)
        let label = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 30)))
        label.text = "\(value)"
       label.translatesAutoresizingMaskIntoConstraints = false
        self.tabBar.addSubview(label)
   }
}
