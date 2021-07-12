import Foundation

class FavouriteInteractor: FavouriteInteractorProtocol {
    private let dataBase: FavouriteDataBaseProtocol
    required init(dataBase: FavouriteDataBaseProtocol) {
        self.dataBase = dataBase
    }
    
    func getFavouriteBooks(completion: (([BookProtocol]) -> Void)) {
        dataBase.getFavourite(completion: completion)
    }

}
