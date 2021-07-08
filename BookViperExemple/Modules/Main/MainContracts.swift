import Foundation
import Moya

protocol MainViewProtocol: AnyObject {
    func showBooks()
    func updateProgressBar(progress: Float)
}

protocol MainPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, interactor: MainInteractorProtocol, router: MainRouterProtocol)
    func searchBooks(search: String)
    func getCellCount(at section: Int) -> Int
    func getCellData(indexPath: IndexPath) -> BookProtocol
    func getSectionCount() -> Int
    func getSectionTitle(at section: Int) -> String
    func selectCell(indexPath: IndexPath)
}

protocol MainInteractorProtocol: AnyObject {
    init(remoute: NetworkRequest)
    func getBooks(search: String, completion: @escaping (Result<[BookProtocol], DescriptionError>) -> ())
}

protocol MainRouterProtocol: AnyObject {
    init(view: MainViewController, factory: Factory)
    func openAboutBook(book: BookProtocol)
}

struct DescriptionError: Error {
  let description: String
}
