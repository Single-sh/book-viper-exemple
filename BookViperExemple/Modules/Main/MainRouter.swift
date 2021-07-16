import Foundation

final class MainRouter: MainRouterProtocol {
    private unowned var view: MainViewController
    private let factory: MainAssembler
    
    required init(view: MainViewController, factory: MainAssembler) {
        self.view = view
        self.factory = factory
    }
    
    func openAboutBook(book: BookProtocol) {
        let aboutController = factory.getAboutViewController(book: book)
        view.present(aboutController, animated: true)
    }
}
