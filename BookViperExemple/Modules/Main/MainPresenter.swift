import Foundation

final class MainPresenter: MainPresenterProtocol {
    private unowned var view: MainViewProtocol
    private var interactor: MainInteractorProtocol
    private var router: MainRouterProtocol
    
    required init(view: MainViewProtocol, interactor: MainInteractorProtocol, router: MainRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func searchBooks(search: String) {
        interactor.getBooks(search: search) { [weak view] result in
            switch result {
            case let .success(books):
                view?.showBooks(books: books)
            case let .failure(error):
                print(error.description)
            }
        }
    }
}
