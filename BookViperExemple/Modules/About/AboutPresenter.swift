import Foundation

class AboutPresenter: AboutPresenterProtocol {
    private unowned let view: AboutViewProtocol
    private let interactor: AboutInteractorProtocol
    private let book: BookProtocol
    
    private var actionButton = FavouriteAction.save
    
    required init(view: AboutViewProtocol, interactor: AboutInteractorProtocol, book: BookProtocol) {
        self.view = view
        self.interactor = interactor
        self.book = book
    }
    
    func viewDidLoad() {
        view.showBook(book: book)
        actionButton = interactor.isContains(id: book.id!) ? .remove : .save
        view.setupFavourite(action: actionButton)
    }
    
    func favouriteButtonTap() {
        switch actionButton {
        case .save:
            actionButton = interactor.save(book: book) ? .remove : .save
        case .remove:
            actionButton = interactor.remove(id: book.id!) ? .save : .remove
        }
        view.setupFavourite(action: actionButton)
    }
}
