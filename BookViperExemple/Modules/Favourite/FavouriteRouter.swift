import Foundation

class FavouriteRouter: FavouriteRouterProtocol {
    private unowned var view: FavouriteViewController
    private let factory: Factory
    
    required init(view: FavouriteViewController, factory: Factory) {
        self.view = view
        self.factory = factory
    }
    
    func showAboutView(book: BookProtocol) {
        let aboutController = factory.getAboutViewController(book: book)
        view.present(aboutController, animated: true)
    }
    
}
