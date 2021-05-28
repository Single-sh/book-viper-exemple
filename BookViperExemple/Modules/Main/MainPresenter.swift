import Foundation

class MainPresenter: MainPresenterProtocol {
    unowned var view: MainViewProtocol
    var interactor: MainInteractorProtocol
    var router: MainRouterProtocol
    
    init(view: MainViewProtocol, interactor: MainInteractorProtocol, router: MainRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func searchBooks(search: String) {
        interactor.getBooks(search: search)
    }
    
    func showBooks(books: [Book]) {
        view.showBooks(books: books)
    }
    
    
}
