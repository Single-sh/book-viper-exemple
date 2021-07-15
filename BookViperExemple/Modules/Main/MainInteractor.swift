import Foundation
import Moya

final class MainInteractor: MainInteractorProtocol {
    let remouteService: NetworkRequest
    
    required init(remoute: NetworkRequest) {
        self.remouteService = remoute
    }
    
    func getBooks(search: String, completion: @escaping (Result<[BookProtocol], DescriptionError>) -> ()) {
        remouteService.request(way: GoogleBooksWay.getList(search: search)) { (result: Result<ListBooks, DescriptionError>) in
            switch result {
            case let .success(response):
                completion(.success(response.items))
            case let .failure(error):
                completion(.failure(.init(description: error.localizedDescription)))
            }
        }
    }
    
}
