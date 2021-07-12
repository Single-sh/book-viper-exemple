import Foundation

class FavouritePresenter: FavouritePresenterProtocol {
    private unowned let view: FavouriteViewProtocol
    private let interactor: FavouriteInteractorProtocol
    private let router: FavouriteRouterProtocol
    private var books = [BookProtocol]()
    required init(view: FavouriteViewProtocol, interactor: FavouriteInteractorProtocol, router: FavouriteRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        interactor.getFavouriteBooks { [weak self] in
            guard let self = self else { return }
            self.books = $0
            self.view.updateData()
        }
    }
    
    func didSelectCell(indexPath: IndexPath) {
        let book = books[indexPath.row]
        router.showAboutView(book: book)
    }
    
    func getCountRow() -> Int {
        books.count
    }
    
    func getBook(indexPath: IndexPath) -> BookProtocol {
        books[indexPath.row]
    }
}
