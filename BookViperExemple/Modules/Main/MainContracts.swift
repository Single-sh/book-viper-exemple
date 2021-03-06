import Foundation
import Moya

protocol MainViewProtocol: AnyObject {
    func updateData()
    func updateProgressBar(progress: Float)
}

protocol MainPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, interactor: MainInteractorProtocol, router: MainRouterProtocol)
    func searchBooks(search: String)
    func getCellCount(at section: Int) -> Int
    func getBook(indexPath: IndexPath) -> BookProtocol
    func getSectionCount() -> Int
    func getSectionTitle(at section: Int) -> String
    func selectCell(indexPath: IndexPath)
}

protocol MainInteractorProtocol: AnyObject {
    init(remoute: NetworkRequest)
    func getBooks(search: String, completion: @escaping (Result<[BookProtocol], DescriptionError>) -> ())
}

protocol MainRouterProtocol: AnyObject {
    init(view: MainViewController, factory: MainAssembler)
    func openAboutBook(book: BookProtocol)
}

struct DescriptionError: Error {
  let description: String
}
