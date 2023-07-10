//
//  BestSellerCellViewModel.swift
//
//  Created by Семен Гайдамакин on 28.06.2023.
//

import Foundation

protocol InputHomeCellProtocol {
    var title : String? { get }
    var pictureUrlString : String? { get }
}

class BestSellerCellViewModel: InputHomeCellProtocol {
    
    var data : HomeData?
    let networking : PhoneManager?

    var bestSeller : [BestSellerItem] {
        data?.bestSeller ?? []
        
    }
    
    var index = 0
    
    func set(indexPath: IndexPath){
        index = indexPath.row
    }
 
    
    var title: String? {
        bestSeller[index].title
        
    }
    
    var discountPrice : String? {
        String(bestSeller[index].discountPrice)
    }
    
    var fullPrice : String? {
        String(bestSeller[index].priceWithoutDiscount)
    }
    
    var pictureUrlString : String? {
        bestSeller[index].picture
    }
    
    
    init(data: HomeData?, networking: PhoneManager?) {
        self.data = data
        self.networking = networking
        
        guard let networking = networking else { return }
        networking.getHomeScreenData(completion: { [weak self] data in
            DispatchQueue.main.async {
            switch data {
            case .success(let data) :
                self?.data = data
                print("aaaaaAAAAAaa: \(data)")
            case .failure(let error) :
                print("error")
            }
                
            }
        })
        }
}
    

