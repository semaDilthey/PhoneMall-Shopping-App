
import Foundation
import UIKit

protocol Networking {
    func getHomeData(completion: @escaping (Result<HomeData, Error>) -> Void)
    func getDetailsData(completion: @escaping (Result<ProductDetailsData, Error>) -> Void)
    func getCartData(completion: @escaping (Result<CartData, Error>) -> Void)
}


class NetworkManager: Networking {
    
    var dataFetcher : DataFetcherProtocol!
    
    init(dataFetcher: DataFetcherProtocol = DataFetcher()) {
        self.dataFetcher = dataFetcher
    }
        
    func getHomeData(completion: @escaping (Result<HomeData, Error>) -> Void) {
        dataFetcher.getData(from: API.home, completion: completion)
      }
      
    func getDetailsData(completion: @escaping (Result<ProductDetailsData, Error>) -> Void) {
        dataFetcher.getData(from: API.details, completion: completion)
      }
      
    func getCartData(completion: @escaping (Result<CartData, Error>) -> Void) {
        dataFetcher.getData(from: API.cart, completion: completion)
      }

}

