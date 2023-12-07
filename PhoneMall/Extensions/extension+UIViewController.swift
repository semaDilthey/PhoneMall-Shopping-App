

// Дает возможность смотреть изменения в Live Режиме
// обязателен import swiftUI
// Этот код, потом в главном VC вот такое в конце вставляем
//struct ViewControllerProvider : PreviewProvider {
//    static var previews: some View {
//        MainViewController().showPreview()
//        MyCartVC().showPreview()
//        TabBarViewController().showPreview()
//        ProductDetailsVC().showPreview()
//          или любые другие вью которые нам нужны
//    }
//}


import SwiftUI

extension UIViewController {
    private struct Preview : UIViewControllerRepresentable {
        let viewController : UIViewController
        
        func makeUIViewController(context: Context) -> some UIViewController {
            viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
    
    func showPreview() -> some View {
        Preview(viewController: self).edgesIgnoringSafeArea(.all)
    }
    
}


