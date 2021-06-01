import Foundation
import Moya

final class MainInteractor: MainInteractorProtocol {
    let remouteService: MoyaProvider<RemouteBookService>
    
    required init(remoute: MoyaProvider<RemouteBookService>) {
        self.remouteService = remoute
    }
    
    func getBooks(search: String, completion: @escaping (Result<[Book], DescriptionError>) -> ()) {
        remouteService.request(.getList(search: search)) { result in
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
    }
    
}
