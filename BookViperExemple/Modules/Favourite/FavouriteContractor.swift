import Foundation

protocol FavouriteViewProtocol: AnyObject {
    func updateData()
}

protocol FavouritePresenterProtocol: AnyObject {
    init(view: FavouriteViewProtocol, interactor: FavouriteInteractorProtocol, router: FavouriteRouterProtocol)
    func viewDidLoad()
    func didSelectCell(indexPath: IndexPath)
    func getCountRow() -> Int
    func getBook(indexPath: IndexPath) -> BookProtocol
}

protocol FavouriteInteractorProtocol: AnyObject {
    init(dataBase: FavouriteDataBaseProtocol)
    func getFavouriteBooks(completion: (([BookProtocol]) -> Void))
}

protocol FavouriteRouterProtocol: AnyObject {
    init(view: FavouriteViewController, factory: Factory)
    func showAboutView(book: BookProtocol)
}
