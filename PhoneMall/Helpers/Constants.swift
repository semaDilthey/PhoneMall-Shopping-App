//
//  Constants.swift
//  PhoneMall
//
//  Created by Семен Гайдамакин on 06.12.2023.
//

import Foundation
import UIKit

struct Constants {
    struct MainView {
        
    }
    
    struct DetailsView {
        struct Images {
            let favoriteButtonUnselected = UIImage(named: "heartEmpty")?.imageWithColor(color: .white)
            let favoriteButtonSelecded = UIImage(named: "heartFilled")
            let backButton = UIImage(named: "Vector")
            let shopCartButton = UIImage(named: "shopCart")
            
            let processorIcon = UIImage(named: "processor")
            let operativkaIcon = UIImage(named: "operativka")
            let memoryIcon = UIImage(named: "memoryCard")
            let cameraIcon = UIImage(named: "cameraOptions")
        }
    }
    
    struct CartView {
        
    }
}
