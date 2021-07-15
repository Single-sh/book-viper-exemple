import Foundation

final class FavouriteRouter: FavouriteRouterProtocol {
    private unowned var view: FavouriteViewController
    private let factory: FavouriteFactory
    
    required init(view: FavouriteViewController, factory: FavouriteFactory) {
        self.view = view
        self.factory = factory
    }
    
    func showAboutView(book: BookProtocol) {
        let aboutController = factory.getAboutViewController(book: book)
        view.present(aboutController, animated: true)
    }
    
}
