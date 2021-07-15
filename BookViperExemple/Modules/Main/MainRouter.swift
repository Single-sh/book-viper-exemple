import Foundation

final class MainRouter: MainRouterProtocol {
    private unowned var view: MainViewController
    private let factory: MainFactory
    
    required init(view: MainViewController, factory: MainFactory) {
        self.view = view
        self.factory = factory
    }
    
    func openAboutBook(book: BookProtocol) {
        let aboutController = factory.getAboutViewController(book: book)
        view.present(aboutController, animated: true)
    }
}
