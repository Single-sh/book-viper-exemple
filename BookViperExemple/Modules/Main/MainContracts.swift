import Foundation
import Moya

protocol MainViewProtocol: AnyObject {
    func showBooks(books: [Book])
}

protocol MainPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, interactor: MainInteractorProtocol, router: MainRouterProtocol)
    func searchBooks(search: String)
    func getCellCount(at section: Int) -> Int
    func getCellData(indexPath: IndexPath) -> Book
    func getSectionCount() -> Int
    func getSectionTitle(at section: Int) -> String
}

protocol MainInteractorProtocol: AnyObject {
    init(remoute: NetworkRequest)
    func getBooks(search: String, completion: @escaping (Result<[Book], DescriptionError>) -> ())
}

protocol MainRouterProtocol: AnyObject {
    init(view: MainViewController)
}

struct DescriptionError: Error {
  let description: String
}
