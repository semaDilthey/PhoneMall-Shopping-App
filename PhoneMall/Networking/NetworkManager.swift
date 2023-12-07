
import Foundation
import UIKit

protocol GetData {
    func getHomeScreenData(completion: @escaping (Result<HomeData, Error>) -> Void)
    func getDetailsScreenData(completion: @escaping (Result<ProductDetailsData, Error>) -> Void)
    func getCartScreenData(completion: @escaping (Result<CartData, Error>) -> Void)
}


class NetworkManager: GetData {
    
    var dataFetcher : DataFetcherProtocol!
    
    init(dataFetcher: DataFetcherProtocol = DataFetcher()) {
        self.dataFetcher = dataFetcher
    }
        
    func getHomeScreenData(completion: @escaping (Result<HomeData, Error>) -> Void) {
        dataFetcher.getData(from: API.home, completion: completion)
      }
      
    func getDetailsScreenData(completion: @escaping (Result<ProductDetailsData, Error>) -> Void) {
        dataFetcher.getData(from: API.details, completion: completion)
      }
      
    func getCartScreenData(completion: @escaping (Result<CartData, Error>) -> Void) {
        dataFetcher.getData(from: API.cart, completion: completion)
      }

}

