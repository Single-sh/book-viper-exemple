import Foundation
import Moya

final class MainInteractor: MainInteractorProtocol {
    let remouteService: NetworkRequest
    
    required init(remoute: NetworkRequest) {
        self.remouteService = remoute
    }
    
    func getBooks(search: String, completion: @escaping (Result<[Book], DescriptionError>) -> ()) {
        remouteService.request(link: LinkList.getList(search: search)) { (result: Result<ListBooks, DescriptionError>) in
            switch result {
            case let .success(response):
                completion(.success(response.items))
            case let .failure(error):
                completion(.failure(.init(description: error.localizedDescription)))
            }
        }
//        remouteService.request(.getList(search: search)) { result in
//            switch result {
//            case let .success(response):
//                do {
//                    let list = try response.map(ListBooks.self)
//                    completion(.success(list.items))
//
//                }
//                catch {
//                    completion(.failure(.init(description: "Error parse ListBook")))
//                }
//            case let .failure(error):
//                completion(.failure(.init(description: error.localizedDescription)))
//            }
//        }
    }
    
}
