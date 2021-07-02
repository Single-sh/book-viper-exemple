import Foundation

class MainRouter: MainRouterProtocol {
    private unowned var view: MainViewController
    private let factory: Factory
    
    required init(view: MainViewController, factory: Factory) {
        self.view = view
        self.factory = factory
    }
    
    func openAboutBook(book: Book) {
        view.present(factory.getAboutViewController(book: book), animated: true)
    }
}
