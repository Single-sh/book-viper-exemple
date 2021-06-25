import Foundation
import Moya

final class MainInteractor: MainInteractorProtocol {
    typealias RemouteService = AnyObject
    let remouteService: RemouteService
    
    required init(remoute: RemouteService) {
        self.remouteService = remoute
    }
    
    func getBooks(search: String, completion: @escaping (Result<[Book], DescriptionError>) -> ()) {
        if let remoute = remouteService as? NetworkRequest {
            remoute.request(link: LinkList.getList(search: search)) { (result: Result<ListBooks, DescriptionError>) in
                switch result {
                case let .success(response):
                    completion(.success(response.items))
                case let .failure(error):
                    completion(.failure(.init(description: error.localizedDescription)))
                }
            }
        } else if let remoute = remouteService as? MoyaProvider<RemouteBookService> {
            remoute.request(.getList(search: search)) { result in
                switch result {
                case let .success(response):
                    do {
                        let list = try response.map(ListBooks.self)
                        completion(.success(list.items))
                        
                    }
                    catch {
                        completion(.failure(.init(description: "Error parse ListBook")))
                    }
                case let .failure(error):
                    completion(.failure(.init(description: error.localizedDescription)))
                }
            }
        } else {
            completion(.failure(.init(description: "operation not equatable")))
        }
    }
    
}
